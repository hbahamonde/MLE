### R code from vignette source 'Poisson.Rnw'

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
dat <- read.dta("https://stats.idre.ucla.edu/stat/data/hsbdemo.dta")


###################################################
### code chunk number 3: summary
###################################################
summary(dat)


###################################################
### code chunk number 4: hist
###################################################
plot(dat$prog)


###################################################
### code chunk number 5: ref
###################################################
is(dat$prog)[1] # ok, es factor
dat$prog2 <- relevel(dat$prog, ref = "academic") # ref cat


###################################################
### code chunk number 6: modelo
###################################################
p_load(nnet)
modelo <- multinom(prog2 ~ ses + write, data = dat)


