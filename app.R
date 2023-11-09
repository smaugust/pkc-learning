################################
#PKC LEARNING APP
#
# A web/mobile app to help teach
# basic concepts about public-key
# cryptography (PKC).  The app can
# be used on its own, but was 
# designed to facilitate several 
# guided activities during a
# lecture about PKC.
#
# Author: David August
# Date: Nov 3, 2023
# Version: 2.1
################################

DEBUG_MODE <- FALSE

library(shiny)
library(shinyjs)
library(bignum)
library(R.utils)

library(spsComps)
library(stringdist)
library(shinyFeedback)
library(shinyalert)
library(glue)

#UI and SERVER code
source('pkcUI.R', local=TRUE)
source('pkcServer.R', local=TRUE)

#My uilities (EG: functions to generate key, encrypt, decrypt, etc.)
source('pkc-utils.R', local=TRUE)

#Run the shiny app
shinyApp(ui = pkcUI, server = pkcServer)
