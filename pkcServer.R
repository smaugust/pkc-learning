#library(shinyjs)
#library(bignum)
#library(R.utils)
#library(spsComps)
#library(stringdist)
#library(shinyFeedback)
#library(shinyalert)
#library(glue)
#######################################################
#Text screens for spash-page, 'Huh?'-button messages, and 'ideas' tab
source('pkcTextSplash.R', local=TRUE)  
source('pkcTextHuh.R', local=TRUE)  
source('pkcTextLearn.R', local=TRUE)  
#######################################################


pkcServer <- function(input, output, session) {
  
if (DEBUG_MODE) {
  rsconnect::showLogs()
}  
  
  observe({
    if (input$close > 0) stopApp() 
  })
  
  nk <- reactive( vv$data )
  #output$gobutton <- renderText({ gobutton_label(nk()) })
  output$gobutton <- renderText({ gobutton_label(input$message, nk()) })
  #output$gobutton <- renderText({ 
  #  if (input$message=="") gobutton_label(NULL) 
  #  else gobutton_label(nk()) 
  #})
  
  myReactives <- reactiveValues()  
  observe(myReactives$current_mtype <-  input$msg_type) 
  observe(myReactives$current_todo1 <-  input$todo1) 
  observe(myReactives$current_todo2 <-  input$todo2) 
  
#Set up labels, etc for the "USE-1-KEY" tab
  onekey_pub <- "Someone else\'s <font color=green>PUBLIC</font> key"
  onekey_priv <- "Your <font color=red>PRIVATE</font> key"
  onekey_labels <- c(onekey_pub, onekey_priv, onekey_priv, onekey_priv, onekey_pub)

  repeated_private_label <- "Your <font color=red>PRIVATE</font> key"
  repeated_public_label <- "Someone\'s <font color=green>PUBLIC</font> key"
  twokeys_label_1 <- c(repeated_private_label, repeated_private_label, repeated_private_label,
                       repeated_private_label, repeated_private_label)
  twokeys_label_2 <- c("Your <font color=green>PUBLIC</font> key", repeated_public_label, 
                       repeated_public_label, repeated_public_label, repeated_public_label)

#Generic error-messages for checking validity of keys (invalid_key() function)
  key_errors <- c("Number must be > 2", 
                  "Must be an ODD number", 
                  "Sorry, 129 happens to be a weak key", 
                  "Number must be < 257")                 

#If trying to encrypt (etc) before specifying both a message and one or more keys...
  default_usekey_msg <- HTML(paste("<h3><b>LOOKS EMPTY...</b></h3>", 
            "<h4><b><i><br>Before I can do anything here, 
            I need a MESSAGE and KEY (or KEYS).</i></b></h4>"))
  
#Set up aliases, titles, and messages for the various help (AKA 'Huh?') buttons  
  tab_names <- c("intro", "translate", "hash", "genkey", 
                 "message", "use1key", "use2keys", "use_keys")
  
  tab_titles <- c("INTRO", "TRANSLATE", "HASH", "KEY-PAIR", 
                  "MESSAGE", "USE 1 KEY", "USE 2 KEYS", "GO!")
  tab_title <- setNames(as.list(tab_titles), tab_names)

  tab_strings <- c(explain_intro_text, explain_translate_text, 
                   explain_hash_text, explain_genkey_text, explain_message_text,
                   explain_use1key_text, explain_use2keys_text, explain_apply_text)
  
  tab_learnstrings <- c(learn_intro_text, learn_translate_text, 
                   learn_hash_text, learn_genkey_text, learn_message_text,
                   learn_use1key_text, learn_use2keys_text, learn_apply_text)
  
  tab_string <- setNames(as.list(tab_strings), tab_names)
  tab_learnstring <- setNames(as.list(tab_learnstrings), tab_names)
  
  #If any of the help-buttons are clicked, display appropriate message
  observeEvent(input$explain_intro_btn, { show_help(tab_title$intro, tab_string$intro) })
  observeEvent(input$explain_translate_btn, { show_help(tab_title$translate, tab_string$translate) })
  observeEvent(input$explain_hash_btn, { show_help(tab_title$hash, tab_string$hash) })
  observeEvent(input$explain_genkey_btn, { show_help(tab_title$genkey, tab_string$genkey) })
  observeEvent(input$explain_message_btn, { show_help(tab_title$message, tab_string$message) })
  observeEvent(input$explain_use1key_btn, { show_help(tab_title$use1key, tab_string$use1key) })
  observeEvent(input$explain_use2keys_btn, { show_help(tab_title$use2keys, tab_string$use2keys) })
  observeEvent(input$explain_apply_btn, { show_help(tab_title$use_keys, tab_string$use_keys) })

  #################################
  observeEvent(input$learn_intro_btn, { show_help("Learn!", tab_learnstring$intro) })
  observeEvent(input$learn_translate_btn, { show_help(tab_title$translate, tab_learnstring$translate) })
  observeEvent(input$learn_hash_btn, { show_help(tab_title$hash, tab_learnstring$hash) })
  observeEvent(input$learn_genkey_btn, { show_help(tab_title$genkey, tab_learnstring$genkey) })
  observeEvent(input$learn_message_btn, { show_help(tab_title$message, tab_learnstring$message) })
  observeEvent(input$learn_use1key_btn, { show_help(tab_title$use1key, tab_learnstring$use1key) })
  observeEvent(input$learn_use2keys_btn, { show_help(tab_title$use2keys, tab_learnstring$use2keys) })
  observeEvent(input$learn_apply_btn, { show_help(tab_title$use_keys, tab_learnstring$use_keys) })
  #################################

  observeEvent(input$nerd_btn, {
    #showModal(modalDialog(title = nerd_title, nerd_txt, easyClose = TRUE ))
    show_splash(nerd_title, nerd_txt)
  })  
  observeEvent(input$about_btn, {
    #showModal(modalDialog(title = about_title, about_txt, easyClose = TRUE ))
    show_splash(about_title, about_txt)
  })  
  observeEvent(input$legal_btn, {
    #showModal(modalDialog(title=legal_title, legal_txt, easyClose = TRUE ))
    show_splash(legal_title, legal_txt)
  })
  
  #Code-block for TRANSLATE tab
  #A MINIMALIST setup for "translate" feature in PKC-learning app
  #Set up / display different input-field labels (depending on
  #whether user is starting with 'English' or with 'Numbers').
  input_format <- reactive({
    if(input$radio6 == '1'){
      HTML("<p whitespace:nowrap><h3><b><u>MESSAGE</u></b></h3>
        <h4><b>(Regular English: <i>'Hi there!'</i>)</b></h4></p>")
    } else {
      HTML("<p whitespace:nowrap>
        <h3><b><u>MESSAGE</u></b></h3>
        <h4><b>(Numbers & spaces: <i>'39 83 117 112 63'</i>)</b></h4>")
    }
  })
  
  output$what_to_translate <- renderUI({
    #textInput("original", label = h4(input_format() ))
    textInput("to_translate", label = input_format() )
  })
  
  observeEvent(input$tx_button, {
    if (input$to_translate == "" || is.null(input$radio6)) {
      return()
    } else {
      #English-messages get translated 'automatically'
      if (input$radio6=="1") {
        out_string <- paste(utf8ToInt(input$to_translate), collapse=" ")
        isolate(out_string)
        output$the_translation <- renderUI({ out_string })
        #output$the_translation <- renderText({ out_string })
        
      } else {
        
        #Numerical messages need validation: return a 3-element validation-info list
        ww2 <- validate_message(input$radio6, input$to_translate)
        if (ww2[[1]]) {
          #Message was valid (i.e., ww[[1]] == true)
          #Run through each character and replace 'non-printable' ones with a special symbol
          out_string <- ""
          for (w in ww2[[2]]) {
            if (w>=32 && w<=126) out_string <- paste(out_string, intToUtf8(w), sep="")
            else out_string <- paste(out_string, "\u2B24", sep="")
          }
          
          #NOTE: To avoid HTML automatically collapsing multiple-spaces into 
          #a single space, must use the 'preformatted text' tag here.  This 
          #is NOT needed when translated from English to numbers, though.
          ss <- paste("<pre>", out_string, "</pre>", sep="")
          isolate(out_string)
          output$the_translation <- renderUI({ HTML(ss) })
          
        } else {
          #Message was NOT VALID: show an error-specific shinyalert 
          generic_alert("Wrong format", ww2[[3]], "Got it!", "red", "error")
          
        } #If message was valid...     (ie, ww2[[1]]==TRUE)
      }   #If message was numerical... (ie, radio6!=1))
    }     #If message & translation-type both exist... (ie, input$to_translate & input$radio6)
  })  
  
  #Code-block for "GENERATE KEY" tab
  #Show current private-key selection
  
  #FINE! output$private_key <- renderText( { input$private }) 
  
  #ALSO FINE! output$private_key <- renderUI( { HTML(paste("<h2><b>",input$private,"</b></h2>")) }) 
 
  output$private_key <- renderUI({
    s1 <- "<h2><b><font color=red>PRIVATE:</font>"
    s2 <- "</b></h2>"
    HTML(paste(s1, input$private, s2))
  }) 
  
  #Calculate the public-key partner for input$private
  ########
  #THIS WORKS FINE! 
  #kpub <- eventReactive(input$private, { genkey(input$private, 257) })
  #######
  kpub <- eventReactive(input$private, { 
    if (input$private == "129") {
      generic_alert("Invalid key", 
                    "Sorry, 129 is a \'weak\' key.", 
                    "Try again...", 
                    "red", "error")
    }
    genkey(input$private, 257) 
  })
  
  #Display the result, freezing/isolating it until gen_key button pressed again
  observeEvent(input$gen_key, {
    #FINE!!! output$public_key <- renderText({ isolate( kpub()) })
    #output$public_key <- renderUI({ isolate( kpub()) })
    s1 <- "<h2><b><font color=green>PUBLIC:</font>"
    s2 <- "</b></h2>"
    output$public_key <- renderUI({ HTML(paste(s1, isolate(kpub()), s2)) })
  })

#Code-block for MESSAGE tab
  #RETURN a list of INTEGERS equivalent to input$message
  m_int <- reactive({
    req(input$msg_type, input$message)
    
    if (input$msg_type == "1") {
        utf8ToInt(input$message)
      
    } else {
        #Replace 'mutliple-space' with single spaces
        single_spaced <- gsub("([ ]){1,}", " ", input$message) #Remove >1 spaces in a row
        no_leading <- gsub("^[ ]", "", single_spaced)          #Remove leading space(s)
        #Split into a list of words (each one [hopefully] a positive integer)
        word_list <- strsplit(no_leading, split=" ", fixed=TRUE)
        m.list <- unlist(word_list)
        m.nums <- as.integer(as.numeric(m.list))
    }
  }) #end-reactive

  observeEvent(input$msg_confirm, {
    if (input$message == "" || is.null(input$msg_type)) {
      return()
      
    } else {
      #Return a 3-element list with validation info
      ww <- validate_message(input$msg_type, input$message)

      #Show different alerts, depending on whether the
      #message was valid (i.e., was ww[[1]] == true or false?)
      if (ww[[1]]) generic_alert("All set!", ww[[3]], "Got it!", "green", "success")
      else generic_alert("Uh oh...", ww[[3]], "Got it!", "red", "error")
    }
  })
          
  observeEvent(input$msg_reset, {
    updateTextInput(session, "message", value = "")
  })
  
  output$the_message <- renderText({ input$message })

  #hh: The first 32 bits of SHA512 hash, formatted as 2-hexdigit strings separated by colon
  #For hashing the original message (input$message)...
  hh_msg <- reactiveValues(data = NULL)
  observeEvent(input$message,  { hh_msg$data <- digest(input$message, algo="sha512", raw=T) })

  observeEvent(input$hash_btn, {
    req(input$to_hash)
      
    #RAW HASH DIGEST -- 128 hexdigits
    thehash_full <- digest(input$to_hash, algo="sha512", raw=T) 
    
    #Reduced HEX format: pairs of hexdigits, each pair separated by a colon
    thehash_hex <- paste(thehash_full[1:4], collapse=":") 
    
    #Reduced INT format: vector of 4 integers (each 0-255)
    thehash_int <- format_hash(thehash_full)
    
    ss1 <- "<b>Base-16 format:</b>  "
    ss2 <- "<br><br><b>Decimal format:</b>  "
    ss3 <- paste(thehash_int, collapse=" ")

    output$thehash <- renderUI({ 
      HTML(paste("<h4>", ss1, thehash_hex, ss2, ss3, "</h4>")) 
    })
  }) #HASH-tab
  
#CODE BLOCK FOR USE-1-KEY / USE-2-KEYS tabs
  observeEvent(input$todo1,
               if (input$todo1 == "0") {
                 return() 
                 
               } else {
                 s1 <- "<h4><b>"
                 s2 <- onekey_labels[as.integer(input$todo1)]
                 s3 <- "</b></h4>"
                 
                 output$onekey_label <- renderUI({ 
                   HTML( paste(s1,s2,s3) ) 
                 })
               }
  ) #use-1-key tab
  
  observeEvent(input$todo2,
    #Create LABELS for the numericInput widgets used to input two keys.
    #Labels  depend on whether user wants to use both their keys, 
    #or one of theirs paired with someone else's.
    if (input$todo2 == "0") {
      return() 
    } else {
      output$twokeys_label_1 <- renderUI({  
        HTML( paste("<h3><b>", twokeys_label_1[as.integer(input$todo2)],"</b></h3>") ) 
      })         
      output$twokeys_label_2 <- renderUI({  
        HTML( paste("<h3><b>", twokeys_label_2[as.integer(input$todo2)],"</b></h3>") ) 
      })         
    }
  ) #use-2-keys tab
  
  #keyframe <- reactive(
  #  data.frame(
  #    type = c("generic", "private", "public"),
  #    value = c(input$k1, input$k2_1, input$k2_2)
  #  )
  #)
  
  observeEvent(input$confirm_1_key, {
    req(input$todo1, input$k1)
    updateRadioButtons(session, input$todo2, selected="0")
    keys <- as.integer(input$k1)
    numkeys <- length(keys)
    
    kcheck <- invalid_keys(keys, 257)
    if (kcheck == -1) { #Key is NULL
      return()
    } else if (kcheck == 0) {  #Key is valid
      generic_alert("Key checks out", "", "Got it!", "green", "success")
    } else { #The key is not valid
      generic_alert("Invalid key", key_errors[kcheck], "Try again...", "red", "error")
    }
  })
  
  observeEvent(input$confirm_2_keys, {
    req(input$todo2, input$k2_private, input$k2_public)
    updateRadioButtons(session, input$todo1, selected="0")
    keys <- c(as.integer(input$k2_private), as.integer(input$k2_public))
    numkeys <- length(keys)
    kcheck <- invalid_keys(keys, 257)
    if (kcheck == -1) { #key is NULL
      return()
    } else if (kcheck == 0) {  #Both keys are valid
      generic_alert("Keys check out", "", "Got it!", "green", "success")
    } else {  #One (or more) keys were invalid
      generic_alert("Invalid key", key_errors[kcheck], "Try again...", "red", "error")
    }
  })
  

#vv: the number of keys being used: either 1 or 2; but defaults to NULL 
vv <- reactiveValues(data = NULL)
observeEvent(input$confirm_1_key,  { vv$data <- 1 })
observeEvent(input$confirm_2_keys, { vv$data <- 2 })  

#uu: the cryptographic key(s): either one integer or a 2-integer vector
uu <- reactiveValues(data=NULL)
observeEvent(input$confirm_1_key, { uu$data <- as.integer(input$k1) } )
observeEvent(input$confirm_2_keys, { uu$data <- c(as.integer(input$k2_private), as.integer(input$k2_public))} )

output$summarize_state <- renderUI({
  #Display current summary (message, keys, hash, etc....)
  numkeys <- vv$data #Alias
  keys <- uu$data  #Alias

  if (input$message == ""  
      || any(is.na(m_int()))
      || is.null(input$msg_type) 
      || any(is.na(keys))  #"NA" if user enters, but then deletes, a key  
      || invalid_keys(keys,257)!=0) {
   
    #Some of the required data (key and/or message/hash) is missing
    HTML(default_usekey_msg)

    } else {
    
    s1 <- "SUMMARY"
    s2 <- "========================="
    
    if (numkeys==1) {
      s4 <- paste("Key:       ", paste(keys,collapse=" ")) 
    } else {
      s4 <- HTML(paste0("PRIVATE key: ", keys[1], "<br>","PUBLIC key:  ", keys[2]))

    }
    if (numkeys==1) {
      switch(input$todo1,
        "1" = { summary_lbl <- "Message:   " },
        "2" = { summary_lbl <- "Encrypted message: " },
        "3" = { summary_lbl <- "Message:   " },
        "4" = { summary_lbl <- "Message:   " },
        "5" = { summary_lbl <- "Message:   " },
        "6" = { summary_lbl <- "Encrypted message or hash: " }
      )
    } else { #if (numkeys==2...
      switch(input$todo2,
        "1" = { summary_lbl <- "Message:   " },
        "2" = { summary_lbl <- "Message:   " },
        "3" = { summary_lbl <- "Encrypted, signed message: " },
        "4" = { summary_lbl <- "Message:   " },
        "5" = { summary_lbl <- "Encrypted message + hash:  " }
      )
    } 

    if (input$msg_type=="1") {
      #For English (msg_type==1), just print the message
      s5 <- paste("Message:   ", input$message)
    } else {
      #Otherwise (numerical/msg_type==2), remove excess spaces before printing
      no_multi <- gsub("([ ]){1,}", " ", input$message) #Replace 'multiple-space'
      no_leading <- gsub("^[ ]", "", no_multi)          #Remove leading space(s)
      #Now, display either the WHOLE message string, or everything but the last 4 numbers
      if (numkeys==2 && input$todo2=="5") {
        all_but_hash <- paste(head(m_int(), length(m_int())-4), collapse=" ")
        s5 <- paste("Message:   ", all_but_hash)
      } else {
        s5 <- paste("Message:   ", no_leading)
      }
    }
    
    #s6: An optional string (for ONE-KEY/choice #4) containing message's hash
    s6 <- NULL
    if (numkeys==1 && input$todo1==4) {
        rawhash <- digest(input$message, algo="sha512", raw=T)
        a_hash <- format_hash(rawhash)
        s6 <- paste("Hash:      ", paste(a_hash, collapse=" "))
    } 
  
    if (numkeys==2) {
      if (input$todo2==4) {
        #For TWO KEYS/choice #4, the hash is calculated from 
        #input$messge, (for later signing w/ the user's private key).    
        rawhash <- digest(input$message, algo="sha512", raw=T) 
        a_hash <- format_hash(rawhash)
        s6 <- paste("Hash:      ", paste(a_hash, collapse=" "))
      }
      if (input$todo2==5) {
        #For TWO KEYS/choice #5, the hash will be the LAST FOUR NUMBERS of m_int()
        s6 <- paste("Signed hash: ", paste(tail(m_int(), 4), collapse=" "))
      }
    }
    
    HTML(paste("<pre>", s1, s2, s4, s5, s6, "</pre>", sep="<br>"))
  }
  
})

  
#---------------------------------------------------------  
#Code-block for "APPLY-KEY" tab
  observeEvent(input$use_keys, {
    req(m_int(), uu$data, vv$data)
    numkeys <- vv$data
    keys <- uu$data
    
if (any(is.na(keys))) {
  return
  
} else {
#----------------------------------------------------  
#This block is for ONE KEY (if numkeys==1...)
  if (numkeys==1) {
    
    #Make sure input format (English/numerical) is compatible w/ todo1
    input_format <- myReactives$current_mtype
    verify_1key <- myReactives$current_todo1
    if (input_format=="1" && !is.null(verify_1key) && verify_1key==5) {
      generic_alert("Wrong message format", 
        "To verify something, it must be entered as numbers -- not regular English", 
        "Try again...", "red", "error")
      return()
    }
    
    switch(input$todo1, 
      "1" = { lbl_rr <- "Encrypted message" },
      "2" = { lbl_rr <- "Decrypted message" },
      "3" = { lbl_rr <- "Signed message" },
      "4" = { lbl_rr <- "Signed hash" },
      "5" = { lbl_rr <- "Verified message or hash" }
    )       
    
    #APPLY A KEY, either to the message or its hash
    if (input$todo1=="4") {
      #To sign a hash (if input$todo1==4), first hash the  
      #message and then encrypt hash --- not the message itself!
      thehash_full <- digest(input$message, algo="sha512", raw=T) 
      thehash_int <- format_hash(thehash_full)
      res_int <- apply_one_key(thehash_int, keys[1], 257)
    } else {
      #Otherwise (if not signing a hash), encrypt the original message
      res_int <- apply_one_key(m_int(), keys[1], 257)
    }
    lbl_r <- paste('<b><span style="font-size:16pt">', lbl_rr, '</span></b>') 
    #'<span style="font-size:14pt">(raw format)</span></b>')
    val_r <- paste(res_int, collapse=" ")
    output$final_result <- renderUI({ HTML(paste(lbl_r, "<br>", val_r)) })   

    #TRANSLATING a decrypted message (if applicable)
    if (input$todo1=="2") {
      #Translate the decrypted message from #'s back into English
      #Start by assuming everything will be 'non-printable'
      res_trans <- rep("\u2b24", length(res_int))
      #Then, substitute every decrypted character that IS printable 
      for (i in 1:length(res_int)) {
        if (res_int[i]>=32 & res_int[i]<=126) res_trans[i] <- intToUtf8(res_int[i])
      }
      lbl_t <- '<b><span style="font-size:16pt">Translated</span></b>'
      val_t <- paste(res_trans, collapse="")
      output$final_trans <- renderUI({ HTML(paste(lbl_t, "<br>", val_t)) })
    } else {
      output$final_trans <- renderUI({ NULL })
    }
    
    #Verifying a decrypted HASH
    if (input$todo1=="5") {
      #With ONE KEY, a public key is applied to a message (or hash)
      #to 'verify' it; but the result does not need to be translated
      #or hashed itself.  Therefore, ignore this block...
      
      #decryption <- intToUtf8(res_int)
      #dhash_full <- digest(decryption, algo="sha512", raw=T) 
      #dhash_int <- format_hash(dhash_full)
      #lbl_h <- '<b><span style="font-size:16pt">Hash of decrypted message</span>'
      #val_h <- paste(dhash_int, collapse=" ")
      #output$final_hash <- renderUI({ HTML(paste(lbl_h, "<br>", val_h)) })
    } else {
      output$final_hash <- renderUI({ NULL })
    }
    output$final_hash <- renderUI({ NULL })
    output$final_both <- renderUI({ NULL }) #??Not needed for 1-key

  } else {
#----------------------------------------------------    
#For TWO KEYS (else if numkeys == 2...)
#----------------------------------------------------  
    #Two "message checks":
    #Check-11)Make sure message format (English vs. numbers) is compatible with todo2 choice
    input_format <- myReactives$current_mtype
    verify_2keys <- myReactives$current_todo2
    if (input_format=="1" && !is.null(verify_2keys) && verify_2keys==5) {
      generic_alert("Wrong message format", 
        "To verify something, it must be entered as numbers -- not regular English", 
        "Try again...", "red", "error")
      return()
    }
    #Check-2) If user wants to verify that a signed hash == the decrypted hash,
    #make sure the message is long enough.  Specifically, m_int() must contain 
    #at least 5 numbers: one for the message proper; and 4 for the signed hash.
    if (length(m_int())<5 && !is.null(verify_2keys) && verify_2keys==5) {
      generic_alert("Message too short!", 
                    "Input must have FOUR numbers (signed hash),  
                    plus at least ONE MORE (for the original message).", 
                    "Try again...", "red", "error")
      return()
    }
    
    if (input$todo2 == "4") {
      #In this case, apply DIFFERENT keys to the message & hash
      #Encrypt the message w/ someone else's PUBLIC key
      res_int <- apply_one_key(m_int(), keys[2], 257)
      #Hash the result, and sign w/ user's PRIVATE key
      thehash_full <- digest(input$message, algo="sha512", raw=T) 
      thehash_int <- format_hash(thehash_full)
      e_hash <- apply_one_key(thehash_int, keys[1], 257)

    } else if (input$todo2 == "5") {
      
      #First, extract the "message" and "hash" parts from m_int()
      #Encrypted message = m_int() up until its last 4 elements
      o5_y <- head(m_int(), length(m_int())-4)
      #Signed hash = last 4 elements of m_int()
      o5_sig <- tail(m_int(), 4)
      
      #Next, apply DIFFERENT KEYS to the message & hash
      #Decrypt the MESSAGE w/ user's private key
      res_int <- apply_one_key(o5_y, keys[1], 257)
      #Decrypt the SIGNED HASH w/ someone else's PUBLIC key
      o5_sig_dec <- apply_one_key(o5_sig, keys[2], 257)   
      
    } else {
      #In all other cases, apply both keys to the entire message
      first_res <- apply_one_key(m_int(), keys[1], 257)
      res_int <- apply_one_key(first_res, keys[2], 257)
    }
    
    #Display the encrypted/decrypted MESSAGE...
    if (input$todo2=="1") lbl_rr <- "The result"
    else if (input$todo2=="2" || input$todo2=="4") lbl_rr <- "Encrypted message"
    else lbl_rr <- "Decryption"
    lbl_r <- paste('<b><span style="font-size:16pt">', lbl_rr, '</span></b>') 
        #'<span style="font-size:14pt">(raw format)</span></b>')
    val_r <- paste(res_int, collapse=" ")
    output$final_result <- renderUI({ HTML(paste(lbl_r, "<br>", val_r)) }) 
    #output$final_result <- renderUI({ paste(res_int, collapse=" ") })

    #If any DEcryption is happening, TRANSLATE final_result into English
    if (input$todo2=="1" || input$todo2=="3" || input$todo2=="5") {
      #Assume all translated numbers are 'non-printable'
      #Then, substitute every printable translation into this string 
      res_trans <- rep("\u2b24", length(res_int))
      for (i in 1:length(res_int)) {
        if (res_int[i]>=32 & res_int[i]<=126) res_trans[i] <- intToUtf8(res_int[i])
      }
      
      lbl_t <- '<b><span style="font-size:16pt">Translated </span></b>'
      val_t <- paste(res_trans, collapse="")
      output$final_trans <- renderUI({ HTML(paste(lbl_t, "<br>", val_t)) })
    
    } else {
      output$final_trans <- renderUI({ NULL })
    }  
  
    #Info about HASH (if applicable)....
    if (input$todo2=="4") {
      lbl_h <- '<b><span style="font-size:16pt">Signed hash</span></b>'
      val_h <- paste(e_hash, collapse=" ")
      output$final_hash <- renderUI({ HTML(paste(lbl_h, "<br>", val_h)) })
      
      lbl_b <- '<b><span style="font-size:16pt">Final output</span></b>'
      val_b <- paste(c(res_int, e_hash), collapse=" ")
      output$final_both <- renderUI({ HTML(paste(lbl_b, "<br>", val_b)) })
      
    } else if (input$todo2=="5") {
      #To decrypt a message & verify its hash...
      lbl_h <- '<b><span style="font-size:16pt">Decrypted hash</span></b>'
      d_hash <- o5_sig_dec
      val_h <- paste(paste(d_hash, collapse=" "))
      output$final_hash <- renderUI({ HTML(paste(lbl_h, "<br>", val_h)) })
      
      vhash_full <- digest(paste(res_trans,collapse=""), algo="sha512", raw=T) 
      vhash_int <- format_hash(vhash_full)
      
      #Does the hash of the decrypted message (vhash_int) match 
      #the decryption of the original signed hash (o5_sig_dec)?
      if (all(d_hash == vhash_int)) 
        check <- "<h4><b>** <font color=green>VALID:</font> Hashes match **</b></h4>"
      else
        check <- "<h4><b>** <font color=red>WARNING!</font> Hashes differ **</b></h4>"
      
      output$final_both <- renderUI({ 
        HTML(paste('<b><span style="font-size:16pt">Hash of decryption</span></b>', 
                   '<br>', paste(vhash_int, collapse=" ")), '<br>', check, '</b>' )  
      })
      
    } else { #If no hash is involved...
      output$final_hash <- renderUI({ NULL })
      output$final_both <- renderUI({ NULL })
    }
    
  }   #if using two keys
  }   #if !cant_apply_keys  
})  #use_keys button
#---------------------------------------------------      
} #END SERVER
