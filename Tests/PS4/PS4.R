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
## 1.2 Negative-Binomial.
## 1.3 Zero-Inflated Poisson.
## 1.4 Zero-Inflated Negative-Binomial.

# 2. 
# 2.1 Explica el "data generating process" de cada especificación (i.e., 1.1, 1.2, 1.3, 1.4). 
# 2.2 Menciona y testea los supuestos de cada modelo. (a) Para esto necesitas citar lineas ESPECIFICAS de los textos usados en clases. Evita el plagio: recuerda citar. Si no citas, tu respuesta estara incompleta. (b) Incluye los tests especificos de cada modelo cuando corresponda (overdispersion test, vuong test). 

# 3. Para los cuatro modelos, considera los tests en 2.2 (para aquellos modelos que correspondan), ademas considera cada uno de los BIC, AIC y Log-Lik de tu tabla para determinar que modelo es "mejor".

# 4. Usando el "mejor" modelo, usa metodos graficos de predicted probabilities para interpretar SUBSTANTIVAMENTE  todos los predictores del "mejor" modelo.
