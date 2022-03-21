#### Preamble ####
# Purpose: Prepare the 2021 GSS data
# Author: Ray Wen
# Data: 17 March 2022
# Contact: ray.wen@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")
write_csv(raw_data, "outputs/data/raw_gss.csv")


         