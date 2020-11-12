cat("\014")
rm(list=ls())
graphics.off()


# Hypothesis testing: Wald test, Likelihood Ratio, Lagrange Multiplier (práctico)
options(scipen=100000000)
set.seed(2020)

# Data
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(mydata)
summary(mydata)
mydata$rank <- factor(mydata$rank)

#############
# Modelos
#############

# modelo 1
logit.1 <- glm(admit ~ gre + gpa + rank, data = mydata, family = binomial(link = "logit")) # unrestricted
summary(logit.1)

# modelo 2: sin rank
logit.2 <- glm(admit ~ gre + gpa, data = mydata, family = binomial(link = "logit")) # restricted
summary(logit.2)

#############
# Wald Test: probando parametros theta
#############

p_load(aod)

# Wald Test en el Intercepto
aod::wald.test(b = coef(logit.1), Sigma = vcov(logit.1), Terms = 1) # probemos que el primer coef = 0
# Si da significativo, b0 lo es tambien.


aod::wald.test(b = coef(logit.1), Sigma = vcov(logit.1), Terms = 1:2) # probemos que el primer y seg coef = 0
# Si da significativo, b0 Y b1 lo son tambien.

# Debes ingresar el numero de coeficiente segun como sale en el "call" del modelo.
# Sigma entrega la matrix de varianza-covarianza de los errores std.





#############
# Likelihood Ratio: comparando log-lilelihoods
#############

lrtest(logit.1, logit.2) # Fijate que aqui no comparamos parametros, si no que LogLik

# Extraer Lig Likelihood de cada modelo

logLik(logit.1)
logLik(logit.2)

# Que modelo es mejor?

#############
# Lagrange Multiplier
#############

# Otro nombre del Lagrange Multiplier es el Rao Score.
# Notar: "Terms added sequentially (first to last)"

anova(logit.1, test="Rao") # Terminos del modelo 1 son anadidos sequentially y comparados si aportan a mejorar el slope de la curva.


anova(logit.1,logit.2, test="Rao") # Ambos modelos son comparados y ven si EN CONJUNTO ("joint hypothesis") mejoran el slope de la curva. 
