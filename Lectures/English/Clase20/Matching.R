### R code from vignette source 'Matching.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)


###################################################
### code chunk number 2: sim:1
###################################################
set.seed(2020) # seed
#
e = rnorm(1100, 0) # residuo 
x1 = rnorm(1100, -10) # x1
x2 = rnorm(1100, 20) # x2
# mecanismo de asignacion a tratamiento sesgado: depende de x1 y una constante.
t <- as.numeric(1 + 0.02*x1) 
pr = as.numeric(1/(1+exp(-t))) # poner t en una funcion logit invertida
z = rbinom(1100,1,pr) # crear z como funcion binomial basado en el vector de prob's
#
y <- as.numeric(1*z + 1*x1 + 2*x2 + e) # y es combinacion lineal de factores
#
dat = as.data.frame(cbind(y, x1, x2,z)) # crear base de datos


###################################################
### code chunk number 3: sim:2
###################################################
library(lattice)
histogram(z)


###################################################
### code chunk number 4: sim:3
###################################################
library(lattice)
densityplot(x1, groups = z, data = dat)
densityplot(x2, groups = z, data = dat)


###################################################
### code chunk number 5: sim:4
###################################################
# install.packages("MatchIt", dependencies = T)
library("MatchIt")
m.out = matchit(z ~ x1 + x2, 
data = dat, 
method = "nearest", # nearest: "nearest neighbor"
discard = "both",  # botar obs en ambas (T y C)
distance = "logit", 
caliper = .1 # ventana de comparacion entre T y C
)


###################################################
### code chunk number 6: sim:5
###################################################
summary(m.out) # inspeccionar balance y obs botadas


###################################################
### code chunk number 7: sim:6
###################################################
plot(m.out, type = "jitter", interactive = FALSE, col = "blue")
plot(m.out, type = "hist")
plot(m.out, type = "qq", interactive = FALSE)


###################################################
### code chunk number 8: sim:7
###################################################
m.data = match.data(m.out, distance = "prop.score", drop.unmatched = T) # construir DF


