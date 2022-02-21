### R code from vignette source 'ZIP_ZINB_RELOGIT.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)


###################################################
### code chunk number 2: dat:1
###################################################
p_load(foreign)
dat = read.dta("https://github.com/hbahamonde/MLE/raw/master/Datasets/banks.dta")
dat = na.omit(dat) # excluir NAs


###################################################
### code chunk number 3: summary:1
###################################################
summary(dat)


###################################################
### code chunk number 4: table:2:1
###################################################
table(dat$coups)


###################################################
### code chunk number 5: modelo
###################################################
p_load(pscl)
modelo.zip = zeroinfl(coups ~ demonstrations + guerilla + party_frac | guerilla, 
dist = 'poisson', 
data = dat)
modelo.zinb = zeroinfl(coups ~ demonstrations + guerilla + party_frac | guerilla, 
dist = 'negbin', 
data = dat)


