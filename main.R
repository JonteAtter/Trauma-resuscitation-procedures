
library(tidyverse)
library(rofi)
library(bookdown)
library(dplyr)
library(noacsr)
library(ggplot2)
library(DiagrammeR) 
library(table1)
library(rsvg)
library(descr)


data <- rofi::import_data(test = TRUE)
names <- c("swetrau","fmp","atgarder","problem","kvalgranskning2014.2017")
names(data) <- names

## Merge data
combined.dataset <- rofi::merge_data(data)

## Create OFI column
combined.dataset$ofi <- rofi::create_ofi(combined.dataset)
combined.dataset <- clean_audit_filters(combined.dataset)

## Separate and store cases without known outcome (OFI)
missing.outcome <- is.na(combined.dataset$ofi)
combined.dataset <- combined.dataset[!missing.outcome,]

## remove patients < 15 years
combined.dataset <- combined.dataset[combined.dataset$pt_age_yrs > 14,]

## Fix formating and remove wrong values like 999
combined.dataset <- clean_all_predictors(combined.dataset)

## clean Audit filters
combined.dataset <- clean_audit_filters(combined.dataset)
#Do we need to run this a second time?

## Create a flow chart (Saves it as a pdf)
#
# Sätter # framför create_flowchart(combined.dataset) för att slippa skapa ny pdf varje gång
#
#create_flowchart(combined.dataset)

mean.age<- round(mean(combined.dataset[,"pt_age_yrs"]), digits = 2)
