# Mental Health of U.S. Citizens During the COVID-19 Pandemic

For this report, we used the US GSS 2021 data to better understand factors that may affect American's mental health.

## Obtaining data

The data is available on https://gss.norc.org/

- Get the Data -> STATA -> "Individual Year Data Sets (cross-section only)" -> 2021

It is also included in this repository, in the directory "inputs/data/2021_stata/gss2021.dta"

## Preprocess data

After obtaining the STATA data on GSS, the script "01-data_preparation.R", located in "scripts/01-data_preparation.R", can be used to preprocess the data and save the file as a csv file in the directory "outputs/data/raw_data.csv"

## Reproducing Graphs

In the script "02-data_visualization.R", located in "scripts/02-data_visualization.R", contains all the code that is necessary to reproduce the graphs as shown in the paper. 

This script uses the file that is located in the path "inputs/data/2021_stata/gss2021.dta".

## Building the Report

There is a RMarkDown document located in "outputs/paper/paper.Rmd". This file is used to produce the report "Mental Health of U.S. Citizens During the COVID-19 Pandemic". It contains the R code to produce the graphs and the report format code. The reference used are also located in "outputs/paper/references.bib".




