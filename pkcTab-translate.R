#---------------------------------------------------      
#A MINIMALIST setup for "translate" feature in PKC-learning app
Tab_translate <- tabPanel("TRANSLATE", uiOutput("Tab_translate"),

  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_translate_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_translate_btn", "Learn", class="btn_learn"),offset=1, width=2),
  )),   
    
  fluidRow(column(4,
    br(),
    radioButtons("radio6", 
    h3("What kind of translation?"),
    selected = "1", 
    choices = c("English-to-Numbers" = "1", "Numbers-to-English"= "2"))
  )),
  
  fluidRow(column(4,
    #Show correct label (English/numbers) and obtain "input$to_translate"
    uiOutput("what_to_translate"),
    br()
  )),
  
  fluidRow(column(4,
    div(style="position:relative; left:calc(25%)", 
      actionButton("tx_button", "Translate!", 
      style="color:white; background-color:blue; border-color:black",
      class="btn-lg")
    )
  )),
            
  fluidRow(column(4, 
    br(),
    h3(HTML("<b>TRANSLATION</b>")),
    h4(HTML("<b><u>(\u2B24 means 'non-printable')</u></b>")),
    uiOutput("the_translation")
  ))
)   #tab
#---------------------------------------------------      
