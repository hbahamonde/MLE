### R code from vignette source 'Inferencia_Interpretacion.Rnw'

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
# Data
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(mydata)
summary(mydata)


###################################################
### code chunk number 3: l:1
###################################################
logit.1 <- glm(admit ~ gre + gpa, data = mydata, family = binomial(link = "logit"))
summary(logit.1)


###################################################
### code chunk number 4: i:c
###################################################
confint(logit.1)


###################################################
### code chunk number 5: ci:plot
###################################################
p_load(jtools,ggstance,broom.mixed)
plot_summs(logit.1)


###################################################
### code chunk number 6: od:ra
###################################################
p_load(oddsratio)
#
odds = or_glm(data = mydata, 
       model = logit.1, 
       incr = list(gre = mean(mydata$gre), gpa = mean(mydata$gpa) + sd(mydata$gpa)))
odds


###################################################
### code chunk number 7: od:plot
###################################################
par(mfrow=c(1,2))
hist(mydata$gpa, main = "GPA")
hist(mydata$gre, main = "GRE")


###################################################
### code chunk number 8: means
###################################################
mean(mydata$gpa)
mean(mydata$gre)


###################################################
### code chunk number 9: sc1
###################################################
p_load(margins)
summary(margins(logit.1, 
        at = list(
          gre = min(mydata$gre), 
          gpa = max(mydata$gpa))
        ))


###################################################
### code chunk number 10: sc2
###################################################
summary(margins(logit.1, 
        at = list(
          gre = max(mydata$gre), 
          gpa = mean(mydata$gpa))
          ))


###################################################
### code chunk number 11: sc3
###################################################
par(mfrow=c(1,2))
cplot(logit.1, "gre", what = "effect") # effect para mostrar cambios marginales
cplot(logit.1, "gpa", what = "effect") # effect para mostrar cambios marginales


###################################################
### code chunk number 12: predict:1
###################################################
head(predict(logit.1))
summary(predict(logit.1))
plot(predict(logit.1)) # logit scale


###################################################
### code chunk number 13: logit:prob:1
###################################################
logit.scale = as.numeric(predict(logit.1)) # extraer vector y'
prob.scale = exp(logit.scale)/(1+exp(logit.scale)) # exponenciar
head(prob.scale) # ve como se ve y' en formato prob
summary(prob.scale) # resumen de y' en formato prob (bounded)


###################################################
### code chunk number 14: logit:prob:2
###################################################
par(mfrow=c(1,2)) # divide el panel de graf's en dos
plot(mydata$gre, prob.scale) # para gre
plot(mydata$gpa, prob.scale) # para gpa


###################################################
### code chunk number 15: predict:2
###################################################
p_load("effects")
plot(predictorEffects(logit.1)) # Todo el modelo 


###################################################
### code chunk number 16: tabla:1
###################################################
# generar los rangos de los perfiles deseados
gpa.bajo <- with(mydata, 
                data.frame(
                        gre = c(min(mydata$gre), max(mydata$gre)), 
                        gpa = min(mydata$gpa))
                )
gpa.medio <- with(mydata, 
                 data.frame(
                         gre = c(min(mydata$gre), max(mydata$gre)), 
                         gpa = mean(mydata$gpa, na.rm = T))
                         )
gpa.alto <- with(mydata, 
                      data.frame(
                              gre = c(min(mydata$gre), max(mydata$gre)), 
                              gpa = max(mydata$gpa))
                              )


###################################################
### code chunk number 17: tabla:2
###################################################
# usar funcion predict
predict(logit.1, gpa.bajo, type="response") # gpa.bajo
predict(logit.1, gpa.medio, type="response") # gpa.medio
predict(logit.1, gpa.alto, type="response") # gpa.alto


###################################################
### code chunk number 18: archivo
###################################################
knitr::purl('Inferencia_Interpretacion.Rnw')
Stangle('Inferencia_Interpretacion.Rnw')


