
Tab_genkey <- tabPanel("KEY-PAIR", uiOutput("Tab_genkey"),
  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_genkey_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_genkey_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),
  #fluidRow(column(2,
    #    actionButton("explain_genkey_btn", "Huh?", class="btn_big_huh")
    #  ),
    #  column(2,
    #    actionButton("learn_genkey_btn", "Learn", class="btn_learn"),
    #  ),
  #),
  fluidRow(column(4, 
    h3(HTML("<b>Choose a <font color=red>SECRET</font> key</b>")),
      sliderInput("private", label = "",
      min = 3, max = 255, step = 2, value = 127)
  )),
  fluidRow(column(4, 
    h3(HTML("<b>Generate a <font color=green>PUBLIC</font> key</b>")),
    div(style="position:relative; left:calc(15%)", 
    #div(style="display:inline-block; float:center",
    #div(style="margin:0 auto",
    actionButton("gen_key", "GENERATE", 
        style="color:black; background-color:orange; border-color:black; 
        font-weight:bold; font-size:18pt;", class="btn-lg"))
  )),


  br(),
  fluidRow(column(4, uiOutput("private_key"))),
  fluidRow(column(4, uiOutput("public_key"))),
)       
#----------------------------
