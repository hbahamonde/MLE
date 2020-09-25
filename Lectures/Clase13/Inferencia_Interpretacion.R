### R code from vignette source 'Inferencia_Interpretacion.Rnw'

###################################################
### code chunk number 1: setup20
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
### code chunk number 5: od:ra
###################################################
p_load(oddsratio)
#
or_glm(data = mydata, 
       model = logit.1, 
       incr = list(gre = 380, gpa = 5))


###################################################
### code chunk number 6: od:plot
###################################################
par(mfrow=c(1,2))
hist(mydata$gpa, main = "GPA")
hist(mydata$gre, main = "GRE")


###################################################
### code chunk number 7: means
###################################################
mean(mydata$gpa)
mean(mydata$gre)


###################################################
### code chunk number 8: sc1
###################################################
p_load(margins)
summary(margins(logit.1, 
        at = list(
          gre = min(mydata$gre), 
          gpa = max(mydata$gpa))
        ))


###################################################
### code chunk number 9: sc2
###################################################
summary(margins(logit.1, 
        at = list(
          gre = max(mydata$gre), 
          gpa = min(mydata$gpa):mean(mydata$gpa))
          ))


###################################################
### code chunk number 10: sc3
###################################################
par(mfrow=c(1,2))
cplot(logit.1, "gre")
cplot(logit.1, "gpa")


###################################################
### code chunk number 11: predict:1
###################################################
head(predict(logit.1))
plot(predict(logit.1)) # logit scale
plot(predict(logit.1, type="response")) # Predicted Prob


###################################################
### code chunk number 12: predict:2
###################################################
p_load("effects")
par(mfrow=c(1,1))
plot(predictorEffects(logit.1)) # Todo el modelo (PLURAL)
par(mfrow=c(1,2))
plot(predictorEffect("gre", logit.1)) # Solo una variable (SINGULAR)
plot(gpa.pred.prob <- predictorEffect("gpa", logit.1)) # Solo una variable (SINGULAR)


###################################################
### code chunk number 13: tabla:1
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
### code chunk number 14: tabla:2
###################################################
# usar funcion predict
predict(logit.1, gpa.bajo, type="response")
predict(logit.1, gpa.medio, type="response")
predict(logit.1, gpa.alto, type="response")


###################################################
### code chunk number 15: archivo
###################################################
knitr::purl('Inferencia_Interpretacion.Rnw')
Stangle('Inferencia_Interpretacion.Rnw')


