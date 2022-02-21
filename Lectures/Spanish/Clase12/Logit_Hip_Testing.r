cat("\014")
rm(list=ls())
graphics.off()


# Hypothesis testing: Wald test, Likelihood Ratio, Lagrange Multiplier (práctico)
if (!require("pacman")) install.packages("pacman"); library(pacman) 
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
logit.1 <- glm(admit ~ gre + gpa + rank, data = mydata, family = binomial(link = "logit")) # unrestricted (full)
summary(logit.1)

# modelo 2: sin rank
logit.2 <- glm(admit ~ gre + gpa, data = mydata, family = binomial(link = "logit")) # restricted
summary(logit.2)

#############
# Wald Test: probando parametros theta
#############

p_load(aod)

# The key assumption is that the coefficients asymptotically follow a (multivariate) normal 
# distribution with mean = model coefficients and variance = their var-cov matrix. 
## O SEA, TENEMOS EL VERDADERO MODELO.

# Null Hyp: b=0
# SI es sign., hay evidencia suficiente para rechazar la nula y aceptar la HA (b es distinto a 0).

# Wald Test en el Intercepto
aod::wald.test(b = coef(logit.1), Sigma = vcov(logit.1), Terms = 2, df= length(coef(logit.1))) 
# probemos que el segundo coef (gre) = 0
# Si da significativo, aceptar la HA (b es distinto a 0).
# Vemos que no es significativo, asi que aceptamos la nula de que b2=0.


aod::wald.test(b = coef(logit.1), Sigma = vcov(logit.1), Terms = c(1,6), df= length(coef(logit.1)) ) 
# probemos que el primer (Intercept) y sexto (rank4) coef son  = 0.
# Si da significativo, aceptar la HA (b es distinto a 0).
# Vemos que SI es significativo, asi que RECHAZAMOS la nula de que b1 y b6=0.


# Debes ingresar el numero de coeficiente segun como sale en el "call" del modelo.
# Sigma entrega la matrix de varianza-covarianza de los errores std.


#############
# Likelihood Ratio: comparando log-likelihoods
#############
p_load(lmtest)

# Extraer Lig Likelihood de cada modelo
logLik(logit.1)
logLik(logit.2)

# Que modelo es mejor?


lrtest(logit.1, logit.2) # Fijate que aqui no comparamos parametros, si no que LogLik's


#############
# Lagrange Multiplier
#############

# Otro nombre del Lagrange Multiplier es el Rao Score.
# Notar: "Terms added sequentially (first to last)"

anova(logit.1, test="Rao") # Terminos del modelo 1 son anadidos sequentially y comparados si aportan a mejorar el slope de la curva.


anova(logit.1,logit.2, test="Rao") # Ambos modelos son comparados y ven si EN CONJUNTO ("joint hypothesis") mejoran el slope de la curva. 
