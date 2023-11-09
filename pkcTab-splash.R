Tab_splash <- tabPanel("INTRO", uiOutput("Tab_splash"),
  fluidRow(column(4,
    HTML('<h2><b><p style="text-align:center">
          Public-key Crypto
          <br>Learning Tool
          </p></b></h2>'), 
  )),
  
  br(),
  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_intro_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block; position:relative; left:calc(30%)",actionButton("learn_intro_btn", "Learn", class="btn_learn"), width=1),
    
  )),
  
  br(),
  fluidRow(
    column(4, #offset=1,
      actionButton("nerd_btn", "Nerd?", class="btn_splash"),  
  )),
  
  br(),
  fluidRow(column(4,
      div(style="display:inline-block", 
          actionButton("about_btn", "About", class="btn_splash"), width=2),
    div(style="display:inline-block; position:relative; left:calc(20%)",
        actionButton(inputId='close', label="EXIT", class="btn_quit",
                       onclick = "setTimeout(function(){window.close();},500);"),
        width=1)
  )),
  
  br(),
  fluidRow(
    column(4, #offset=1,
      actionButton("legal_btn", "Legal", class="btn_splash"),     
  )),
  
  #br(),
  #fluidRow(column(4,
  #  div(style="position:relative; left:calc(25%);",
  #    actionButton(inputId='close', label="EXIT", class="btn_quit",
  #                 onclick = "setTimeout(function(){window.close();},500);"),
  #  )
  #))
)