#-----------------------------------------
#If user wants to do something using TWO KEYS (private and public,
#theirs and someone else's), this tab selects what action and 
#confirms that the key is OK.

Tab_2keys <-  tabPanel("2 KEYS", uiOutput("Tab_2keys"), 

  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_use2keys_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_use2keys_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),                 
                       
  #fluidRow(column(5,
  #  div(style="position:relative; left:calc(33%)", 
  ##    actionButton("explain_use2keys_btn", "Huh?", class="btn_big_huh")
  #  ),
  #)),

  HTML("<h3><b>What would you like to do?</b></h3>"),   
  fluidRow(column(4,
    radioButtons("todo2", label=NULL, inline=F, selected=0,
      choices=list("Are my keys really opposites?"=1, 
                   "Encrypt & sign a message"=2, 
                   "Decrypt & verify a message"=3,
                   "Encrypt a message & sign its hash"=4,
                   "Decrypt message and hash; verify hash"=5))
  )),
#  fluidRow(column(2,
#                  numericInput("k2_private", 
#                               label=uiOutput("twokeys_label_1"),
#                               value=NULL, min=3, max=255, step=2),
#                  tags$header(
#                    tags$style(type="text/css", "#k2_private {font-weight:bold; font-size:32px; height:64px}")
#                  )
#  )),
  
  fluidRow(column(4, uiOutput("twokeys_label_1"))),
  fluidRow(column(2,
      numericInput("k2_private", 
      label=NULL,
      #label=uiOutput("twokeys_label_1"),
      value=NULL, min=3, max=255, step=2),
      tags$header(
        tags$style(type="text/css", "#k2_private {font-weight:bold; font-size:32px; height:64px}")
      )
  )),
  #br(),
  fluidRow(column(4, uiOutput("twokeys_label_2"))),
  fluidRow(column(2,
      numericInput("k2_public", 
      label=NULL,
      #label=uiOutput("twokeys_label_2"),
      value=NULL, min=3, max=255, step=2),
      tags$header(
        tags$style(type="text/css", "#k2_public {font-weight:bold; font-size:32px; height:64px}")
      ) 
  )),
    
  
  #fluidRow(column(4, align="left", 
  #  #wellPanel( uiOutput("twokeys_label") )
  #  uiOutput("twokeys_label")
  #)),
  #fluidRow(column(4, offset=1,
  #  numericInput("k2_1", width="40%", label=NULL, value=NULL, min=3, max=255, step=2),
  #    tags$header(tags$style(type="text/css", 
  #    "#k2_1 {font-weight:bold; font-size:32px; height:64px}")), 
  #  
  #  numericInput("k2_2", width="40%", label=NULL, value=NULL, min=3, max=255, step=2),
  #    tags$header(tags$style(type="text/css", 
  #    "#k2_2 {font-weight:bold; font-size:32px; height:64px}"))
  #  )),
 
  fluidRow(column(4, align="left",
    div(#style="position:relative; left:calc(33%)", 
      actionButton("confirm_2_keys", "CONFIRM KEYS",
        style="font-weight:bold; font-size:18pt; height:60px; color:black; background-color:orange; border-color:brown",
        class="btn btn-large")
    ) #div
  ))
) 
###########################################################
