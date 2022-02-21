### R code from vignette source 'Likelihood_Inferencia.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)
if (!require("pacman")) install.packages("pacman"); library(pacman) 



###################################################
### code chunk number 2: ols:mle
###################################################
# cocinemos los datos
n <- 1000
x1 <- rnorm(n, mean = 150, sd = 3)
x2 <- rnorm(n, mean = 100, sd = 2)
e  <- rnorm(n, 0)
y  <- 5 + 2*x1 + 3*x2 + e
# OLS:
ols <- lm(y ~ x1 + x2)
# GLS
mle <- glm(y ~ x1 + x2, family=gaussian)
# Tabla
p_load(texreg)
screenreg(l = list(ols, mle), custom.model.names=c("OLS", "MLE"))


###################################################
### code chunk number 3: ll:d
###################################################
# cocinemos los datos
n <- 1000 # sample size es 1000
ym = 3 # promedio de y es 3.
# Funcion para encontrar el LL
pi=c(1:100)/100
logl=function(pi) n*(ym*log(1-pi)+log(pi))
score=function(pi) n*(1/pi-ym/(1-pi))
logl1=n*(ym*log(1-pi)+log(pi))
score1=n*(1/pi-ym/(1-pi))


###################################################
### code chunk number 4: ll:p
###################################################
# Grafico
plot(logl, col="red",xlab="pi",ylab="logl(pi)")
points(pi[score1==0],logl1[pi==pi[score1==0]],pch=2,col="red",cex=0.6)
title("log-likelihood function")


###################################################
### code chunk number 5: grid.search
###################################################
round(max(logl1),1)


###################################################
### code chunk number 6: local.global.max
###################################################
p_load(ggplot2,ggpmisc)
pi <- seq(-5,5,length=10001)
log.lik <- (10*((pi-1)^2)^(1/3))/(pi^2 + 9)
df <- data.frame(pi = pi, log.lik = log.lik)
ggplot(data = df, aes(x = pi, y = log.lik)) + geom_line() + stat_peaks(col = c("red","blue"))


###################################################
### code chunk number 7: output
###################################################
knitr::purl('Likelihood_Inferencia.Rnw')
Stangle('Likelihood_Inferencia.Rnw')


