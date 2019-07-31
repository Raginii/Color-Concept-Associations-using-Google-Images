# This R script fits a linear mixed-effects model to the data
# Here, we compare the Ball, Sector and Sector+Category models and the comparison 
# of these models' performance when using different types of Images.

# REQUIRED - .csv file with data containing the sqaured error from the three models
# used in Exp 1A, 1B and 1C and also with different image types.

# Uncomment to install the package 
# install.packages("lme4")

# Include the installed library
library(lme4)

# Set the working directory
#setwd("path to the folder containing this file")

d <- read.csv('Models_sumSqErr_50.csv', sep = ",", header = TRUE)

# Mod contrasts compare Ball, Sector, and Sector+Category models. 
# M_C1 is Sector+Category vs. Ball and Sector. MC_2 is Sector vs. Ball.

# Img contrasts compare Top50, Photo, and Cartoon images types. I_C1 is Cartoon vs. Top50 and Photo. I_C2 is Photo vs. Top50
# FruitNum numbers each fruit from 1-12

d$Mod = cbind(d$M_C1, d$M_C2)
d$Img = cbind(d$I_C1, d$I_C2)

# Create the model
Model1 = lmer(Err ~ 1 + Mod*Img + (1 + (Mod+Img)|FruitNum), d, control=lmerControl(optimizer="bobyqa", optCtrl=list(maxfun=1000000)))

# Summarize the model
summary(Model1)