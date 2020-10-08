# RDD: Fuzzy

cat("\014")
rm(list=ls())
dev.off();dev.off();
set.seed(1234) # semilla


library(MASS)

# Cocinar Datos Multivariados usando la funcion "mvrnorm" (multivariate random normal).
# Como es multivariada, tendremos mas de un vector (en este caso dos).

mu <- c(0, 0) # los promedios de ambos vectors
sigma <- matrix(c(1, 0.7, 0.7, 1), ncol = 2) # una matriz de varianza-covarianza


d <- as.data.frame(mvrnorm(2000, mu, sigma)) # creamos la base de datos

colnames(d) <- c("x", "y") # le cambiamos los nombres

corte = 0

d$z <- ifelse(d$x <  corte, 0, 0.8) # introducimos FUZZYNESS 
# Si d$x < corte, z es 0 con un 100% de probabilidad.
# Si d$x > corte, z es 1 con un 80% de probabilidad. 
# "Compliance"!

# Hasta ahora "d$z" es un vector de probabilidades (0, y .8). 
table(d$z)

# Metamos ese vector de prob's en una funcion para convertirlos en 0's y 1's
d$z <- sapply(X = d$z, FUN = function(x) rbinom(1, 1, prob = x)) # funcion

# veamos como quedo
table(d$z)

# Fabriquemos que el efecto de Z en Y es 2 (combinacion lineal) 
d$y <- d$y + d$z * 2


plot(d$x, d$y,
     col = c("steelblue", "darkred")[factor(d$z)],  # asignar color para z(1) y z(0)
     pch= 20, # geometria de los circulos
     cex = 0.5, # tamano de los circulos
     xlab = "x",
     ylab = "y")
