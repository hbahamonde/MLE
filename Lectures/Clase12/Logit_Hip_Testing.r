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
logit.1 <- glm(admit ~ gre + gpa + rank, data = mydata, family = binomial(link = "logit"))
summary(logit.1)

# modelo 2: sin rank
logit.2 <- glm(admit ~ gre + gpa, data = mydata, family = binomial(link = "logit"))
summary(logit.2)

#############
# Wald Test
#############

if (!require("pacman")) install.packages("pacman"); library(pacman) 
p_load(lmtest)

waldtest(logit.1, logit.2) # significancia del test: 

# Wald Test con un solo modelo, compara por defecto:

# logit.1
## admit ~ gre + gpa + rank

# logit.0
## admit ~ 1 # solo intercepto
waldtest(logit.1) # significancia del test: 

# Veamos
logit.0 <- glm(admit ~ 1, data = mydata, family = binomial(link = "logit"))

waldtest(logit.1, logit.0) # significancia del test: ?


#############
# Likelihood Ratio
#############

lrtest(logit.1, logit.2) # Fijate que aqui no comparamos parametros, si no que LogLik

# Extraer Lig Likelihood de cada modelo

logLik(logit.1)
logLik(logit.2)

# Que modelo es mejor?

#############
# Lagrange Multiplier
#############

anova(logit.1, logit.2, test="Rao")