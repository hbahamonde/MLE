### R code from vignette source 'Diagnosticos.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)


###################################################
### code chunk number 2: data
###################################################
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(mydata)
summary(mydata)


###################################################
### code chunk number 3: model
###################################################
logit.1 <- glm(admit ~ gre + gpa, data = mydata, family = binomial(link = "logit"))
summary(logit.1)


###################################################
### code chunk number 4: rstandard
###################################################
r = rstandard(logit.1)
head(r)


###################################################
### code chunk number 5: rindexplot
###################################################
plot(1:nrow(mydata), # Numero de Obs
     r, # y
     ylab="Residuos Estandarizados", 
     xlab="Index (Numero de Obs)") 
abline(0, 0)
abline(2, 0)
abline(-2, 0)


###################################################
### code chunk number 6: output
###################################################
knitr::purl('Diagnosticos.Rnw')
Stangle('Diagnosticos.Rnw')


