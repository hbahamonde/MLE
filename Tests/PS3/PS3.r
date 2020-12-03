# Fecha:
# Prof. Héctor Bahamonde.
# Ayudante: Gonzalo Barría.
# Fecha entrega: una semana de plazo desde su fecha de publicacion en uCampus (Tareas).


# Contraceptive Use in Indonesia

# Carga los datos: Contraceptive Use in Indonesia
load(url("https://github.com/hbahamonde/MLE/raw/master/Datasets/Contraceptive_Method_Choice.RData"))


# Resumen
summary(dat)

## CODEBOOK
# "wife_age": edad de la esposa.
# "wife_edu": nivel educ de la esposa.
# "husb_edu": nivel educ del marido.
# "num_child": numero de hijos.
# "islam": cree en el islam? (1=si), (0=no)
# "wife_working": la esposa, trabaja?
# "husb_job": categoria de trabajo del esposo.     
# "SOL_index": standard-of-living index
# "media_exposure": si, no.
# "cmc": Contraceptive Method Choice

# En este ej pensaremos en la frecuencia en que las mujeres de Indonesia usan metodos anti-conceptivos. Veamos como se ve la variable.
plot(dat$cmc)

##########################################################################################

# 1. Utiliza un modelo multinomial para estimar "dat$cmc". 
## 1.1 Que modelo corresponde: multinomial "ordenado" o "desordenado"? 
## 1.2 El modelo que debieras haber escogido tiene dos versiones. Cual es la diferencia entre ambos modelos?

# 2. Estimacion.
## 2.1 Estima ambos modelos. Para ello, escoge entre 3-5 variables independientes y justifica el uso de cada una de ellas. No te olvides de usar una tabla ("screenreg").
## 2.2 Cual hace un mejor trabajo ajustando (fit) la varianza de la variable dependiente? Usa al menos  dos criterios para evaluar el fit de cada modelo. 

# 3. Interpreta graficamente el modelo cuya especificacion se reviso en clase. Para esto, usa tecnicas graficas de predicted probabilities.
