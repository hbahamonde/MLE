### R code from vignette source 'Ordered.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)


###################################################
### code chunk number 2: dat
###################################################
p_load(foreign) 
dat = read.dta("https://github.com/hbahamonde/MLE/raw/master/Datasets/nes92_ordered.dta")


###################################################
### code chunk number 3: summary
###################################################
summary(dat)


###################################################
### code chunk number 4: hist
###################################################
hist(dat$econworse)


###################################################
### code chunk number 5: factor
###################################################
dat$econworse.f = as.factor(dat$econworse) # transforma a factor
head(dat$econworse.f) # ve como queda


###################################################
### code chunk number 6: modelo
###################################################
p_load(MASS) 
o.logit = polr(econworse.f ~ ideology + educyears + faminc, data = dat,  method = "logistic") # o-logit
o.probit = polr(econworse.f ~ ideology + educyears + faminc, data = dat,  method = "probit") # o-probit


