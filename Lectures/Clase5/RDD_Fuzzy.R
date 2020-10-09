# RDD: Fuzzy

cat("\014")
rm(list=ls())
dev.off();dev.off();
set.seed(1234) # semilla

if (!require("pacman")) install.packages("pacman"); library(pacman) 
p_load(foreign)


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


# plot
plot(d$x, d$y,
     col = c("steelblue", "darkred")[factor(d$z)],  # asignar color para z(1) y z(0)
     pch= 20, # geometria de los circulos
     cex = 0.5, # tamano de los circulos
     xlab = "x",
     ylab = "y")

# linea vertical 
abline(v = 0, lty = 2)

# Estimar Fuzzy RDD
p_load(rddtools)

# declarar que objeto "d" es un data frame de RDD
data <- rdd_data(d$y, d$x, 
                 cutpoint = corte, 
                 z = d$z 
                 )

# veamos
head(data)

# Estimar modelo fuzzy RDD
rdd_reg_lm(rdd_object = data, slope = "same")

# rdd_reg_lm() aplica 2SLS: el tratamiento z es predicho usando X en la primera etapa. Despues se obtiene z' de la primera etapa y se mete (junto X) en la segunda etapa para estimar y. 

# En este caso D (el efecto causal, o rho) es aprox. 2. 




# LATE: Local Average Treatment Effect
p_load(rdd)

band <- IKbandwidth(d$x, d$y)
d_rdd  <- d[d$x < band & d$x > -band, ] # corta la base: quedarse con los valores de x: 0.5 por lado
summary(d_rdd) # veamos la max y min de x de la nueva base datos cortada
linear_rdd_model <- lm(y ~ x + z, data=d_rdd)
summary(linear_rdd_model) # z es LATE

