# PS2
# MLE

# En este ej pensaremos en las variables que hacen que la gente apoye o rechace la guerra del Golfo Persico ("gulfwarworthit")


# Carga la base de datos.
library(foreign) 
dat = read.dta("https://github.com/hbahamonde/MLE/raw/master/Datasets/golfo.dta")

## Este es el Codebook
# ideology (Respondent's ideological placement; 1=Very liberal thru 7=Very conservative);
# bushideo (Bush's ideological placement by the respondent);
# clintideo (Clinton's ideological placement by the respondent);
# distbushideo (Distance between respondent and Bushís ideological placement);
# distclintideo (Distance between respondent and Clintonís ideological place- ment);
# econworse (Economy worse than a year ago? 1=Much better 2=Better 3=Same 4=Worse 5=Much worse)
# oppforce (Opposition to use of military force)
# gulfwarworthit (0/1 dummy coded 1 if respondent thinks it was worth the cost);
# pid (Party ID, from -3=Str Dem thru 3=Str Rep);
# educyears (Years of schooling);
# govtemp (0/1 where 1 if Government employee);
# union (0/1 where 1 if someone in the household belongs to a union);
# faminc (Household income, in thousands of dollars);
# minority (0/1 where 1 if respondent non-white.


# 1. Resume las variables de esta base (puede ser un grafico o una tabla).
summary(dat)

# 2. Nuestra variable dependiente es "gulfwarworthit" (si acaso la Guerra del Golfo valio la pena). Piensa en que variables dependientes puedan explicar este fenomeno (entre 2 y 4 variables). Estima un modelo logit y un modelo probit para el mismo set de variables. Discute brevemente los resultados del modelo logit y probit. Cual es la diferencia? Cual es el supuesto mas importante que difiere entre el modelo logit y el probit? (cita la bibliografia correspondiente leida en el curso).
logit.m = glm(gulfwarworthit ~ , data = dat, family = binomial(link = "logit")) 
probit.m = glm(gulfwarworthit ~ , data = dat, family = binomial(link = "probit")) 

library(texreg)
summary(list(logit.m, probit.m))

# Ambos moelos debieran ser muy parecidos. El estudiante debe decir esto.
# La diferencia es que el probit tiene una distribucion normal con promedio cero y varianza 1 (todo esto lo debe decir). El estudiante debe citar tambien para tener full credit.


# 3. Desde este momento solo trabajaremos con la especificacion logit. Usa el modelo que disenaste en #2 (ese modelo es el modelo  "no restringido"). Explica por que. Ahora disena un modelo "restringido". Compara el modelo restringido con el no restringido usando el Wald Test, el  Likelihood Ratio Test y el Lagrange Multiplier. Que puedes aprender de cada comparacion en cada uno de estos tests?

# Es "No restringido" porque tiene todas sus variables independientes.
# Modelo restringido abajo: CON MENOS variables. El estudiante es libre de decidir que parametros dejar afuera.
logit.r = glm(gulfwarworthit ~ , data = dat, family = binomial(link = "logit")) 

# Wald: comparando parametros
library(aod)
aod::wald.test(b = coef(logit.r), Sigma = vcov(logit.r), Terms = 1) # Aqui el estudiante puede cambiar que parametro testear (aqui estamos testeando el primero). La idea es que compare si ese parametro cambia respecto a logit.m. Con un Wald test es suficiente. El estudiante debe declarar que aqui esta testeando parametros.

# Likelihood Ratio: comparando log-lilelihoods
lrtest(logit.m, logit.r) # El estudiante debe clarificar que aqui no comparamos parametros, si no que LogLik's


# Lagrange Multiplier: 
anova(logit.m, test="Rao") # Terminos del modelo son anadidos sequentialmente y comparados si aportan a mejorar el slope de la curva. El estudiante debe declarar el aporte de cada parametro en la mejora del LL.


# 4. Usando la especificacion no restringida, emplea la tecnica de predicted probabilities (mediante el uso de graficos) para interpretar substantivamente el modelo. Que puedes aprender del modelo?
library("effects") 
plot(predictorEffects(logit.m))
# El estudiante debe saber interpretar TODOS los parametros. Referirse a los intervalos de confianza, y la parte substantiva tambien.


# 5. Empleando los DFBETAS y DFFITS, el pseudo-R2 y los dos information criteria (BIC & AIC), diagnostica los residuos de tu modelo restringido y no restringido. Cual modelo es mejor? 

# DFBETAS
library(car)
dfbetaPlots(logit.m)

# DFFITS
dffits = dffits(logit.m)
n = nrow(dat)
k = length(logit.m$coefficients)-1
cv = 2*sqrt(k/n)
plot(dffits(logit.m)) # grafico de dffits 
abline(h = cv, lty = 2) # anadir cv hacia arriba 
abline(h = -cv, lty = 2) # anadir cv hacia abajo

# AIC
AIC(logit.m) 

# BIC
BIC(logit.m) 

# Residuos: el estudiante debe hacer al menos uno de estos dos.
library(car)
residualPlots(logit.m) # 1
influenceIndexPlot(logit.m, vars=c("Cook")) # 2


# Lo de arriba aplica para logit restringido (logit.r) tambien. El estudiante debe hacer los dos y comentar cual es el mejor modelo. Y comentar.


