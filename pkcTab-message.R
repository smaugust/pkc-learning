Tab_message <- tabPanel("MESSAGE", uiOutput("Tab_message"),

  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_message_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_message_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),                 

  fluidRow(column(5,
      radioButtons("msg_type", label = h3(HTML("<b>Message format?</b>")),
      choices = list("English ('Help!')" = 1, 
                     "Numbers ('72 101 108 112 33')" = 2,
                     "Hash    ('8 243 42 105')" = 3),
      selected=0)
  )),
  
  fluidRow(column(5,
      textInput("message", label = h3(HTML("<b>Type message here:</b>")), value = NULL)
  )),
  
  br(),
  fluidRow(column(4,
      div(style = "display:inline-block; float:left;",
          actionButton("msg_confirm", "CONFIRM", align="left", 
          style="font-weight:bold; color:brown; background-color:orange; border-color:black;",
          class="btn-lg")),
      
      #div(style = "display:inline-block; float:right;",
      #  actionButton("msg_reset", "Try again", align="right",
      #  style="font-weight:bold; color:black; background-color:gray; border-color:black",
      #  class="btn-lg"))
  )),
)
