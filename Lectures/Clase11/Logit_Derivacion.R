### R code from vignette source 'Logit_Derivacion.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)
if (!require("pacman")) install.packages("pacman"); library(pacman) 



###################################################
### code chunk number 2: lineal:no:lineal
###################################################
par(mfrow=c(1,2)) 
plot(data.frame(x=jitter(0:10),y=jitter(0:10)), main = "Lineal")
plot(data.frame(x=0:10,y=c(rep(0,5), rep(1,6))), main = "No Lineal")


###################################################
### code chunk number 3: logistic
###################################################
par(mfrow=c(1,2)) 
plot(dlogis(seq(-10, 10, by = 0.1)), main = "PDF Logistic", ylab = "", xlab = "")
plot(plogis(seq(-10, 10, by = 0.1)), main = "CDF Logistic", ylab = "", xlab = "")


###################################################
### code chunk number 4: output
###################################################
knitr::purl('Logit_Derivacion.Rnw')
Stangle('Logit_Derivacion.Rnw')


