library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(here)
library(tidyverse)
library(googlesheets4)
library(markdown)
library(DT)
library(DTedit)

email <- Sys.getenv('email')
id <- Sys.getenv('id')

options(gargle_oauth_cache = '.secrets')
googlesheets4::gs4_auth(cache = '.secrets', email = email)
sheet <- googlesheets4::read_sheet(id)

users <- sheet %>%
  # Select by index position
  select(c(2:3, 5:13, 15:20)) 

# Convert to data frame
myusers <- as.data.frame(users)

# Define input type vector
myinputs <- c('textAreaInput', 'textAreaInput')

# Assign names to input type vector 
names(myinputs) <- names(myusers)[c(1:2)]