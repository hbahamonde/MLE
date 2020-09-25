### R code from vignette source 'Probabilidad_Incertidumbre.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)
if (!require("pacman")) install.packages("pacman"); library(pacman) 



###################################################
### code chunk number 2: bernoulli
###################################################
# Normal 
p_load(extraDistr)
binomial.ok =  rbern(100, # N
                     prob = 0.5 # probabilidad de obtener 1
                     )
hist(binomial.ok, main = "")

# Cargada 
binomial.cargada =  rbern(100, # N
                     prob = 0.1 # probabilidad de obtener 1
                     )
hist(binomial.cargada, main = "")




###################################################
### code chunk number 3: binomial
###################################################
# 1 Eleccion (observas el total por cada individuo)
rbbinom(20, # N
size = 1 # "Trials" o pruebas
)

# 10 Elecciones (solo observas el total por cada individuo)
rbbinom(20,#N
size = 10 # "Trials" o pruebas
)


###################################################
### code chunk number 4: poisson
###################################################
rtpois(20, # N
       5 # lambda (que es el promedio en una dist Poisson)
       )


###################################################
### code chunk number 5: neg.bin
###################################################
rbnbinom(20, # N
1) # "Trials" o pruebas.


###################################################
### code chunk number 6: output
###################################################
knitr::purl('Probabilidad_Incertidumbre.Rnw')
Stangle('Probabilidad_Incertidumbre.Rnw')


