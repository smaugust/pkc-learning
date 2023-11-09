library(shinyjs)
library(bignum)
library(digest)
library(R.utils)
library(spsComps)
library(stringdist)
library(shinyFeedback)
library(shinyalert)
library(glue)

#Source codes for each individual tabPanel
source('pkcTab-splash.R')
source('pkcTab-translate.R')
source('pkcTab-hash.R')
source('pkcTab-genkey.R')
source('pkcTab-message.R')
source('pkcTab-1key.R')
source('pkcTab-2keys.R')
source('pkcTab-go.R')

pkcUI <- shinyUI({ 

fluidPage(  


  #For the modal dialog message on the intro Tab...
  #tags$head(tags$style(".modal-dialog{ width:450px}")),
  
  #For error-messages, "Huh?", & "Learn" button-info.
  tags$head(tags$style(".shinyalert-dialog{ width:450px}")),
    
    #DEFINE A "CLASS" (ie, roundish and green) for help buttons
    #border-radius: 10-25%=rounded/rectangle; 50%=circle
    tags$head(
      tags$style(HTML('.btn_big_huh {
          display: block;
          height: 80px; width:90px;
          #height: 100px;
          #width: 100px;
          #height: 100%;
          #width: 50%;
          background: green;
          border-radius: 25%; 
          font-weight: bold;
          #font-size: 2em;
          font-size: 18pt;
          color: white;
          button-inactivated: green;
          border: 2px solid;
          border-color: blue}')
      )), 
    
  tags$head(
    tags$style(HTML('.btn_learn {
          display: block;
          #height: 100px;
          #width: 100px;
          height:80px; width:90px;
          background: pink;
          border-radius: 25%; 
          font-weight: bold;
          #font-size: 2em;
          font-size: 18pt;
          color: black;
          button-inactivated: pink;
          border: 2px solid;
          border-color: blue}')
    )),
  
  tags$head(
    tags$style(HTML('.btn_quit {
          display: block;
          height:80px; width:90px;
          background: blue;
          border-radius: 25%; 
          font-weight: bold;
          font-size: 18pt;
          color: white;
          button-inactivated: blue;
          border: 2px solid;
          border-color: black}')
    )),
  
  
    tags$head(
      tags$style(HTML('.btn_splash {
          display: block;
          height: 60px;
          width: 125px;
          background: black;
          border-radius: 15%; 
          font-size: 2em;
          font-style: bold;
          color: white;
          button-inactivated: green;
          border: 2px solid;
          border-color: black}')
      )), 
    
    tags$head(
      tags$style(HTML('.btn_do {
          display: block;
          height: 50px;
          width: 100px;
          background: orange;
          border-radius: 25%; 
          font-size: 1em;
          font-style: bold;
          color: brown;
          border: 2px solid;
          border-color: black}')
      )), 
  
    #This short script (not required) retains the button color after 
    #it has been pressed (e.g., the "Huh?" button stays green instead
    #turning to gray and remaining that way afterwards.)
    tags$script(HTML("
     $(document).ready(function() {
        $('.btn').on('click', function(){$(this).blur()});
      })
  ")),
    
    #includeCSS('/home/daa/R/pkc/pkcButtonStyles.css'),
    shinyFeedback::useShinyFeedback(),
    useShinyjs(),
    tabsetPanel(
      id = "tabSelected",
      #aaa,
      Tab_splash,
      Tab_translate,
      Tab_hash,
      Tab_genkey,
      Tab_message,
      Tab_1key,
      Tab_2keys,
      Tab_go
    )
  ) #fluidpage

})  #UI
