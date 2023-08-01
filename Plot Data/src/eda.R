# Setup script for Project
# Please highlight line 4, 5, 6 & 7 and press "Run" button on top right or press "Source"

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
setwd("..")
library(ProjectTemplate)
load.project()

