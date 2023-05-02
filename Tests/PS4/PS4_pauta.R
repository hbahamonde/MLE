# Prof. Héctor Bahamonde.
# Ayudante: Gonzalo Barría.
# Fecha entrega: una semana de plazo desde su fecha de publicacion en uCampus (Tareas).


# Que ayuda a explicar la productividad cientifica (papers publicados) de los estudiantes de doctorado en bioquimica? 

# Carga los datos
library(AER)
data("PhDPublications")

# Aprende mas de la base de datos
help(PhDPublications)

## En esta tarea pensaremos en la variable dependiente "PhDPublications$articles". La variable CUENTA cuantas publicaciones han sacado estos estudiantes de doctorado.
table(PhDPublications)
hist(PhDPublications)

# 1. Usando las variables independientes "gender", "married", "kids", "prestige" y "mentor", estima los siguientes modelos. Pon todos los resultados en una misma tabla (screenreg).
## 1.1 Poisson.
poisson.m = glm(articles ~ gender + married + kids + prestige + mentor, family="poisson", data=PhDPublications)
## 1.2 Negative-Binomial.
library(MASS)
nb.m = glm.nb(articles ~ gender + married + kids + prestige + mentor, data=PhDPublications)
## 1.3 Zero-Inflated Poisson.
library(pscl)
zip.m = zeroinfl(articles ~ gender + married + kids + prestige + mentor | gender + married + kids + prestige + mentor, dist = 'poisson', data = PhDPublications)
## 1.4 Zero-Inflated Negative-Binomial.
zinb.m = zeroinfl(articles ~ gender + married + kids + prestige + mentor | gender + married + kids + prestige + mentor, dist = 'negbin', data = PhDPublications)

# ATENCION: para la parte del modelo ZIP/ZINB donde se especifica la generacion de 0's el estudiante es libre de especificar lo que ella/el quiera.

library(texreg)
screenreg(list(poisson.m, nb.m, zip.m, zinb.m))

# 2. 
# 2.1 Explica el "data generating process" de cada especificación (i.e., 1.1, 1.2, 1.3, 1.4). 
## Poisson: distribucion discreta (sin decimales), numeros positivos, varianza igual a la media (en la Y).
## Negative-Binomial: distribucion discreta (sin decimales), numeros positivos, varianza no igual a la media (en la Y).
## Zero-Inflated Poisson: distribucion discreta (sin decimales), numeros positivos, exceso de ceros. Varianza es igual a la media (en la Y).
## Zero-Inflated Negative-Binomial: distribucion discreta (sin decimales), numeros positivos, exceso de ceros. Varianza NO es igual a la media (en la Y).


# 2.2 Menciona y testea los supuestos de cada modelo. 

# (a) Para esto necesitas citar lineas ESPECIFICAS de los textos usados en clases. Evita el plagio: recuerda citar. Si no citas, tu respuesta estara incompleta. 
### EL ESTUDIANTE DEBE CITAR A LOS AUTORES EXPLICITAMENTE.

# (b) Incluye los tests especificos de cada modelo cuando corresponda (overdispersion test, vuong test)

## SOLO PARA POISSON: overdispersion test (ver que la media es igual la la varianza).
library(AER) 
options(scipen = 1000000) # apagar notacion cientifica.
dispersiontest(poisson.m) # p-value es significativo: si tenemos evidencia a favor de overdispersion (DEBEMOS estimar un Negative-Binomial).

## SOLO PARA ZERO INFLATED: Vuong test (ver que la media es igual a la varianza)
library(MASS) 
options(scipen = 1000000) # apagar notacion cientifica.
vuong(zip.m, zinb.m) # p-value es significativo: AMBOS modelos son distintos, entonces debemos estimar el ZINB.


### EL ESTUDIANTE DEBE SABER INTERPRETAR CADA UNO DE LOS DOS TESTS.

# 3. Para los cuatro modelos, considera los tests en 2.2 (para aquellos modelos que correspondan), ademas considera cada uno de los BIC, AIC y Log-Lik de tu tabla para determinar que modelo es "mejor".
### ESTUDIANTE DEBE SABER ARGUMENTAR CONSIDERANDO **TODOS** LOS ELEMENTOS ANTES MENCIONADOS. 
### NO MENCIONAR UNO DE ELLOS, INVALIDA ESTA PREGUNTA.
### DADO QUE LAS ESPECIFICACIONES NEGATIVE-BINOMIAL GANAN SEGUN OVERDISPERSION Y VUONG TESTS, EL ESTUDIANTE DEBE AL MENOS SELECCIONAR (Y EXPLICAR POR QUE) UN NB ES MEJOR. 


# 4. Usando el "mejor" modelo, usa metodos graficos de predicted probabilities para interpretar SUBSTANTIVAMENTE  todos los predictores del "mejor" modelo.

# UNA OPCION ES LA SIGUIENTE. PERO EN CLASES SE VIERON VARIAS. TODAS GRAFICAS.
library(effects) 
plot(effect("VARIABLE", MODELO))


