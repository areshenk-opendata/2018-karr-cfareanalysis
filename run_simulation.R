# Sim functions
source('sim_code/modelFit.R')
source('sim_code/importCorMatrix.R')
source('sim_code/bootstrapCor.R')
source('sim_code/runAndSave.R')

# Packages
library(lavaan)
library(semTools)
library(MASS)
library(plyr)

# Parameters
samples = 10
files = list.files('papers', full.names = T)
for (i in 1:length(files)) source(files[i])
