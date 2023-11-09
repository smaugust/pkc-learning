#---------------------------------------------------      
#The HASH feature 
#The first 32 bits of a SHA512 hash. 

Tab_hash <- tabPanel("HASH", uiOutput("Tab_hash"),
                   
  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_hash_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_hash_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),
                                       
#fluidRow(
#  column(2, actionButton("explain_hash_btn", "Huh?", class="btn_big_huh") ),
#  column(2, actionButton("learn_hash_btn", "Learn", class="btn_learn") )
#  ), 
                  
                  
  #fluidRow(column(4,
  #  br(),
  #  div(style="position:relative; left:calc(33%)", 
  #    actionButton("explain_hash_btn", "Huh?", align="center", class="btn_big_huh")
  #  )
  #)),     
                 
  fluidRow(column(4,
    br(),
    HTML('<h3><b><u>Type something...</u></b></h3>'),
    
    #This works to show the EXISTING message (from MESSAGE tab)
    #wellPanel( textOutput("the_message") )
    #Get a 1-time message from the user
    wellPanel(textInput("to_hash", label="" ))
  )),
  
  fluidRow(column(4,
    br(),
    div(style="position:relative; left:calc(25%)", 
      actionButton("hash_btn", "Hash it!", 
        style="color:white; background-color:blue; border-color:black; font-weight:bold; font-size:18pt",
        class="btn-lg")
      )
  )),
            
  fluidRow(column(4, offset=0,
    br(),
    #wellPanel({ uiOutput("thehash") }),
    uiOutput("thehash")
  ))
  
)   #HASH-tab
#---------------------------------------------------      
