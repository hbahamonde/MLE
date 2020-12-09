### R code from vignette source 'Tobit.Rnw'

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
library(AER)
data("Affairs")


###################################################
### code chunk number 3: summary:1
###################################################
table(Affairs$affairs)


###################################################
### code chunk number 4: modelo
###################################################
tobit.m <- tobit(affairs ~ age + yearsmarried + religiousness + occupation + rating, 
                 right = 4,
                 data = Affairs)


