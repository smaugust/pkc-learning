
Tab_go <-  tabPanel("GO!", uiOutput("Tab_go"),

  fluidRow(column(4,
    div(style="display:inline-block",actionButton("explain_apply_btn", "Huh?", class="btn_big_huh"),width=1),
    div(style="display:inline-block",actionButton("learn_apply_btn", "Learn", class="btn_learn"),offset=2, width=1),
  )),                 
  
  #Show pop-up error if signature being verified is formatted
  #as English (i.e., NOT entered as a string of numbers).
  fluidRow( uiOutput("bad_verify") ),
  
  fluidRow(column(4,
    br(),
    wellPanel({ uiOutput("summarize_state") }),
  )),

  fluidRow(column (4,
    #br(),
    div(style="position:relative; left:calc(25%)", 
        actionButton("use_keys", label=textOutput("gobutton"), 
            style="color:black; background-color:orange; border-color:brown;
            font-weight:bold; font-size:16pt",
            class="btn-lg") 
        ),
        br()
  )),         
  
  fluidRow(column(4, 
    #HTML('<b><span style="font-size:18pt">Result </span>
    #<span style="font-size:14pt"> (raw)</span></b>'),
    uiOutput("final_result") 
  )),
      
  fluidRow(column(4,  uiOutput("final_trans") )),
      
  fluidRow(column(4, uiOutput("final_hash") )),
  
  fluidRow(column(4, uiOutput("final_both") ))
   
)
