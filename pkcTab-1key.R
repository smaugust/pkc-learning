#-----------------------------------------
#If user wants to do something using ONE KEY (private or public,
#theirs or someone else's), this tabl selects what action and 
#confirms that the key is OK.
Tab_1key <-  tabPanel("1 KEY", uiOutput("Tab_1key"), 
                      
  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_use1key_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_use1key_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),                 
                      
  #fluidRow(column(5,
  #  div(style="position:relative; left:calc(33%)", 
  #    actionButton("explain_use1key_btn", "Huh?", class="btn_big_huh")
  #  ),
  #)),

  HTML("<h3><b>What would you like to do?</b></h3>"),   
  fluidRow(column(4,
    radioButtons("todo1", label=NULL, inline=F, selected=0,
      choices=list("Encrypt"=1, "Decrypt"=2, 
                   "Sign a message"=3, "Sign a message\'s hash"=4,
                   "Verify a signed message or hash"=5))
  )),


  fluidRow(column(4, align="left", uiOutput("onekey_label") )),
  
  fluidRow(column(4, offset=1,
    numericInput("k1", width="40%", label=NULL, value=NULL, min=3, max=255, step=2),
      tags$header(tags$style(type="text/css", 
      "#k1 {font-weight:bold; font-size:32px; height:64px}"))
    )),
 
  fluidRow(column(4, align="left",
    div(              #IGNORE:style="position:relative; left:calc(33%)", 
      actionButton("confirm_1_key", label="CONFIRM the KEY",
        style="font-weight:bold; font-size:18pt; height:60px; 
        color:black; background-color:orange; border-color:brown",
        class="btn btn-large")
    ) #div
  ))
) 
###########################################################
