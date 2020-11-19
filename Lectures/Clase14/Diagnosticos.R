### R code from vignette source 'Diagnosticos.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)


###################################################
### code chunk number 2: data
###################################################
dat <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(dat)
summary(dat)


###################################################
### code chunk number 3: model
###################################################
logit.1 <- glm(admit ~ gre + gpa, data = dat, family = binomial(link = "logit"))
summary(logit.1)


###################################################
### code chunk number 4: rstandard
###################################################
r = rstandard(logit.1)
head(r)


###################################################
### code chunk number 5: rindexplot
###################################################
plot(1:nrow(dat), # Numero de Obs
     r, # y
     ylab="Residuos Estandarizados", 
     xlab="Index (Numero de Obs)") 
abline(0, 0)
abline(2, 0)
abline(-2, 0)


###################################################
### code chunk number 6: r:pearson:plot
###################################################
plot(density(rstandard(logit.1, type='pearson')))


###################################################
### code chunk number 7: residual:plot
###################################################
p_load(car)
residualPlots(logit.1, layout=c(3,1))


###################################################
### code chunk number 8: d:plot
###################################################
p_load(car)
influenceIndexPlot(logit.1, vars=c("Cook"))


###################################################
### code chunk number 9: DFFITS:n
###################################################
dffits = dffits(logit.1) # calcula el vector de dffits
as.numeric(dffits)[1:10] # ve los primeros 10.


###################################################
### code chunk number 10: DFFITS:n:1
###################################################
n = nrow(dat)
k = length(logit.1$coefficients)-1
cv = 2*sqrt(k/n)


###################################################
### code chunk number 11: DFFITS:p
###################################################
plot(dffits(logit.1)) # grafico de dffits
abline(h = cv, lty = 2) # anadir cv hacia arriba
abline(h = -cv, lty = 2) # anadir cv hacia abajo


###################################################
### code chunk number 12: DFBETAS:n
###################################################
dfbetas = dfbetas(logit.1)
head(dfbetas)


###################################################
### code chunk number 13: DFBETAS:p
###################################################
p_load(car)
dfbetaPlots(logit.1)


###################################################
### code chunk number 14: logit:null
###################################################
logit.null <- glm(admit ~ 1, data = dat, family = binomial(link = "logit"))
summary(logit.null)


###################################################
### code chunk number 15: ll:null:full
###################################################
logLik(logit.1)
logLik(logit.null)


###################################################
### code chunk number 16: r:McFadden
###################################################
1-(logLik(logit.1)/logLik(logit.null))


###################################################
### code chunk number 17: BIC
###################################################
BIC(logit.1,logit.null)


###################################################
### code chunk number 18: AIC
###################################################
AIC(logit.1,logit.null)


###################################################
### code chunk number 19: output
###################################################
knitr::purl('Diagnosticos.Rnw')
Stangle('Diagnosticos.Rnw')


