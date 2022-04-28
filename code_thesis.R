library(Matrix)
library(lattice)
library(mice)
library(miceadds)
library(lme4)
library(merTools)
library(plyr)
library(mitools)
library(dplyr)
library(ggplot2)
library(sjPlot)
library(MASS)
library(rcompanion)
library(olsrr)
library(car)
library(rsq)
library(psycho)
library(tidyverse)
library(MuMIn)
citation(package = "MuMIn") #all

#new nSCR data
d. <- read.table("dat.csv", sep=",", header=TRUE, na.strings="NA")

#for R cloud

d. <- dat

d.$condition <- as.factor(d.$condition)
d.$strategies <- as.factor(d.$strategies)

d.[,"condition"] <- factor(d.[,"condition"], labels = c("control", "fatigue", "no-fatigue"))
d.[,"strategies"] <- factor(d.[,"strategies"], labels = c("control", "Reappriasal", "Distraction", "Labeling", "Reappriasal.", "Distraction.", "Labeling."))

describe(d.)

d.$amp <- d.$Amplitude

#mean each condition
mean_amp <- aggregate(Amplitude ~ condition + strategies, data = d., 
                      FUN = function(x) c(M=mean(x), SD = sd(x), Q = quantile(x, probs = c(0.25, 0.75)), I = IQR(x)))
mean_amp

Boxplot(Amplitude ~ strategies, data = d.)

#g1

g1top <- 1.715 + 1.5*0.359

d.[50, "Amplitude"] <- g1top
d.[239, "Amplitude"] <- g1top


Boxplot(Amplitude ~ strategies, data = d.)
g2top <- 1.68 + 1.5*0.33

d.[184, "Amplitude"] <- g2top
d.[135, "Amplitude"] <- g2top
d.[198, "Amplitude"] <- g2top
d.[261, "Amplitude"] <- g2top
d.[128, "Amplitude"] <- g2top
d.[142, "Amplitude"] <- g2top


g2bot <- 1.35 - 1.5*0.33

d.[191, "Amplitude"] <- g2bot
Boxplot(Amplitude ~ strategies, data = d.)


g3top <- 1.89 + 1.5*0.53
g3top <- g3top - 0.01 

d.[31, "Amplitude"] <- g3top
d.[101, "Amplitude"] <- g3top
d.[227, "Amplitude"] <- g3top
d.[87, "Amplitude"] <- g3top
d.[213, "Amplitude"] <- g3top
d.[192, "Amplitude"] <- g3top
d.[108, "Amplitude"] <- g3top

Boxplot(Amplitude ~ strategies, data = d.)

g4top <- 2.11 + 1.5*0.73

d.[284, "Amplitude"] <- g4top
d.[179, "Amplitude"] <- g4top
d.[305, "Amplitude"] <- g4top
d.[151, "Amplitude"] <- g4top
Boxplot(Amplitude ~ strategies, data = d.)


g5top <- 1.678 + 1.5*0.418


d.[117,"Amplitude"] <- g5top
d.[299,"Amplitude"] <- g5top


Boxplot(Amplitude ~ strategies, data = d.)



g6top <- 1.895 + 1.5*0.535

d.[244,"Amplitude"] <- g6top
d.[307,"Amplitude"] <- g6top
Boxplot(Amplitude ~ strategies, data = d.)



g7top <- 2.055 + 1.5* 0.68

d.[42,"Amplitude"] <- g7top
d.[189,"Amplitude"] <- g7top

Boxplot(Amplitude ~ strategies, data = d.)


mean_amp_cut <- aggregate(Amplitude ~ condition + strategies, data = d., 
                          FUN = function(x) c(M=mean(x), SD = sd(x), Q = quantile(x, probs = c(0.25, 0.75)), I = IQR(x)))
mean_amp_cut



#________________________________________

d.$self.re <- d.$self.report


mean_self <- aggregate(self.report ~ condition + strategies, data = d., 
                       FUN = function(x) c(M=mean(x), SD = sd(x), Q = quantile(x, probs = c(0.25, 0.75)), I = IQR(x)))
mean_self


Boxplot(self.report ~ strategies, data = d.)




#_________________________________________

hist(d.$Amplitude)

#tranform Amplitude by Turkey Method
Amp_t <-
  transformTukey(d.$Amplitude,
                 plotit=FALSE)
plotNormalHistogram(Amp_t)
qqnorm(Amp_t,
       ylab="tukey")
qqline(Amp_t,
       col="red")


d.$Amp_t <- Amp_t


m.amp <- lmer(Amp_t ~ strategies + (1 |id),  data = d., REML=FALSE)
summ.amp <- summary(m.amp)
tab_model(m.amp)
coef(summ.amp)
confint(m.amp, level = 0.95)
performance::r2(m.amp)
psi_a <- coef(summ.amp)[,1]
vpsi_a <- vcov(summ.amp)

#compare with reference group*** 

cmat <-  cbind(c(1,  -1/6, -1/6, -1/6, -1/6, -1/6, -1/6),
               c(0,   1/3,  1/3,  1/3, -1/3, -1/3, -1/3),
               c(0,   1/2,  -1/2,   0, 1/2,  -1/2,    0),
               c(0,   1/2,    0, -1/2,  1/2,    0, -1/2),
               c(0,     0,  1/2, -1/2,    0,  1/2, -1/2),
               c(0,   1/6,  -1/6,   0,  1/6, -1/6,    0),
               c(0,   1/6,    0, -1/6, -1/6,    0,  1/6),
               c(0,     0,  1/6, -1/6,    0, -1/6,  1/6))

est_a <- t(cmat) %*% psi_a
se_a <- sqrt(diag(t(cmat) %*% vpsi_a %*% cmat))
zval_a <- est_a/se_a
pval_a <- round(pnorm(-abs(zval_a)) * 2, 6)
Amp_out <- cbind(est_a, se_a, zval_a, pval_a)
Amp_out
performance::r2(m.amp)

r.squaredGLMM(m.amp)
#_________self.report


m.self <- lmer(self.report ~ strategies + (1 |id),  data = d., REML=FALSE)
summ.self <- summary(m.self)
tab_model(m.self)
coef(summ.self)
confint(m.self, level = 0.95)
r2(m.self)


psi_s <- coef(summ.self)[,1]
vpsi_s <- vcov(summ.self)

cmat <-  cbind(c(1,  -1/6, -1/6, -1/6, -1/6, -1/6, -1/6),
               c(0,   1/3,  1/3,  1/3, -1/3, -1/3, -1/3),
               c(0,   1/2,    0, -1/2,  1/2,    0, -1/2),
               c(0,     0,  1/2, -1/2,    0,  1/2, -1/2),
               c(0,   1/6,    0, -1/6, -1/6,    0,  1/6),
               c(0,     0,  1/6, -1/6,    0, -1/6,  1/6))


est_s <- t(cmat) %*% psi_s
se_s <- sqrt(diag(t(cmat) %*% vpsi_s %*% cmat))
zval_s <- est_s/se_s
pval_s <- round(pnorm(-abs(zval_s)) * 2, 6)
self.report_out <- cbind(est_s, se_s, zval_s, pval_s)
self.report_out



tab_model(m.self)
anova(m.self)

r.squaredGLMM(m.self)