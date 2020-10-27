# MLE
# Problem Set 1
# Fecha de entrega: Lunes 26 de Oct. 5 pm. via uCampus (Tareas).

#################################################################
# Parte Teorica
#################################################################


# 1 Responde en un parrafo: cual es la diferencia entre un experimento y un diseno observacional? Usa las lecturas, y citalas en tu respuesta.











# 2  Responde en un parrafo: cual es "el problema fundamental de la inferencia causal"? Usa las lecturas, y citalas en tu respuesta.










#################################################################
# Parte Practica
#################################################################

# En esta seccion usaras la base "Fatalities"

library(AER)
data("Fatalities")

# Lee la descrip. de la base.

# Traffic fatalities are from the US Department of Transportation Fatal Accident Reporting System. The beer tax is the tax on a case of beer, which is an available measure of state alcohol taxes more generally. The drinking age variable is a factor indicating whether the legal drinking age is 18, 19, or 20. The two binary punishment variables describe the state’s minimum sentencing requirements for an initial drunk driving conviction.

# Total vehicle miles traveled annually by state was obtained from the Department of Transportation. Personal income was obtained from the US Bureau of Economic Analysis, and the unemployment rate was obtained from the US Bureau of Labor Statistics.

# Estas son sus variables junto a su codebook.
head(Fatalities)

# state factor indicating state.
# year factor indicating year.
# spirits numeric. Spirits consumption.
# unemp numeric. Unemployment rate.
# income numeric. Per capita personal income in 1987 dollars. emppop numeric. Employment/population ratio.
# beertax numeric. Tax on case of beer.
# baptist numeric. Percent of southern baptist.
# mormon numeric. Percent of mormon.
# drinkage numeric. Minimum legal drinking age.
# dry numeric. Percent residing in “dry” countries.
# youngdrivers numeric. Percent of drivers aged 15–24.
# miles numeric. Average miles per driver.
# breath factor. Preliminary breath test law?
# jail factor. Mandatory jail sentence?
# service factor. Mandatory community service?
# fatal numeric. Number of vehicle fatalities.
# nfatal numeric. Number of night-time vehicle fatalities.
# sfatal numeric. Number of single vehicle fatalities.
# fatal1517 numeric. Number of vehicle fatalities, 15–17 year olds.
# nfatal1517 numeric. Number of night-time vehicle fatalities, 15–17 year olds. fatal1820 numeric. Number of vehicle fatalities, 18–20 year olds.
# nfatal1820 numeric. Number of night-time vehicle fatalities, 18–20 year olds. fatal2124 numeric. Number of vehicle fatalities, 21–24 year olds.
# nfatal2124 numeric. Number of night-time vehicle fatalities, 21–24 year olds. afatal numeric. Number of alcohol-involved vehicle fatalities.
# pop numeric. Population.
# pop1517 numeric. Population, 15–17 year olds.
# pop1820 numeric. Population, 18–20 year olds. pop2124 numeric. Population, 21–24 year olds. milestot numeric. Total vehicle miles (millions). unempus numeric. US unemployment rate. emppopus numeric. US employment/population ratio. gsp numeric. GSP rate of change.


#################################################################
# 3. Instrumental Variables.
#################################################################

# Consumo de "spirits" (Fatalities$spirits) y desempleo (Fatalities$unemp). La gente bebe porque se queda sin trabajo, o debido a que se quedan sin trabajo beben? Este problema parece ser endogeno. Que causa que? 

# 3.1 Primero, explica por que necesitas una variable instrumental. Cita la bibliografia del curso con paginas especificas. (Un parrafo).
# 3.2 Segundo, que variable vas a instrumentar? Por que? (Una linea).
# 3.3 Tercero, carga la libreria "plm" y estima tu modelo. 
# 3.4 Explica que necesitas poner en "index" y en "model" y por que. (Un parrafo).
# 3.5 Recuerda usar la funcion base de R "predict" para obtener z' (para la segunda etapa). Recuerda transformar tus variables si lo consideras necesario.
# 3.6 Interpeta tus resultados. (Un parrafo).


#################################################################
# 4. Fixed Effects (FE).
#################################################################

# Consumo de "spirits" (vodka, gin, tequila, ron y whisky) y edad minima para beber alcohol. Mucha gente piensa que si se prohibe la ingesta temprana de alcohol, la gente bebera menos. Es esto cierto? 

# 4.1 Usando tecnicas de FE estima el efecto de la edad minima para beber alcohol (Fatalities$drinkage) en el consumo de "spirits" (Fatalities$spirits). Usa y justifica (en dos lineas) al menos dos controles.
# 4.2 Por que debes ocupar fixed effects? Explica (cita la bibliografia referenciada en clases; usa paginas espefificas). Recuerda transformar tus variables si lo consideras necesario. (Un parrafo).
# 4.3 Interpeta tus resultados. (Un parrafo).
# 4.4 Explica con tus propias palabras los supuestos de FE. Para este ej., te pedimos que obvies los supuestos de FE y continua con tu analisis como si los supuestos se cumplieran. (Un parrafo).





