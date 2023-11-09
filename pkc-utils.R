#!/usr/bin/env R
library(bignum)
library(stringr)
library(stringdist) #For printable_ascii
suppressMessages(library(R.utils))

##########################################################
#For validating the key or keys
is_digits <- function (keystring){
  return (all(str_detect(keystring, "^[:digit:]+$")) == TRUE) 
}

##########################################################
invalid_keys <- function (k, p) {
#INPUT: k == list of integer-valued keys; p == prime (default: 257)
#OUTPUT: If k is NULL, return -1;
#        If ALL elements of k() are valid, return 0
#        If ANY elements of k() are invalid, return 1-4 error-code

  if (is.null(k)) retval <- -1
  else if (any(k < 3)) retval <- 1
  else if (any(k %% 2 == 0)) retval <- 2
  else if (any(k == 129)) retval <- 3
  else if (any(k > p-2)) retval <- 4
  else retval <- 0
  return(retval)
}

##########################################################
apply_one_key <- function(x, k, p) {
#Pohlig-Hellman exponentiation cipher: 
#x=plaintext; y=ciphertext; e/d=encryption/decryption keys; p=prime
#y = x^e (mod p);  x = y^d (mod p) 
#PLAINTEXT (x) == Integer array (validated)
#KEY(S) (k) == Single integer (range 3-255; validated)
#p == prime (i.e., 257)
#OUTPUT: Array of integers
  y <- (biginteger(x) ^ biginteger(k)) %% biginteger(p)
  return(as.integer(y))
}

##########################################################
#GENKEY: generate a public key, given a secret key (in range 0-256)
genkey <- function(kpriv, prime) {
#ASSUME: kpriv and prime have already been validated (i.e., kpriv in [0,prime-1])
#Pohlig-Hellman: ed = 1 mod (p-1), where p=prime; e=encryption/secret key; d=decryption/public key
    p.big <- biginteger(prime - 1)
    kpriv.big <- biginteger(kpriv)
    for (k in 0:256) {
      k.big <- biginteger(k)
      res <- (kpriv.big * k.big) %% p.big
      if (res == 1) { 
	      kpub.big = k.big
        break
      } 
    }
    return(kpub.big)
  }

##########################################################
validate_message <- function(xx,yy) {
  #PURPOSE: Validates a message written as English or a string of numbers
  #INPUT: xx=message type (English=1, numbers=2, hash=3 -- special case of 'numbers');
  #       yy=message
  #OUTPUT: returns a 3-element list:
  #  Element-1: true/false, depending on whether message is valid
  #  Element-2: "NA" (if not valid) or a list of positive integers (if valid)
  #  Element-3 a message for the shiny alert (ok, or a specific error-message)
  #EXAMPLE: 
  #After calling v <- validate_message(input$message_type, input$actual_message),
  #we can check validity (v[[1]] == true or false?); see the numerical
  #equivalent (vector v[[2]]); and/or view a descriptive string (v[[3]]).
  
  #If the format is 'Englishi', message is automatically valid
  if (xx == "1") {
    ret <- list(TRUE, 
                utf8ToInt(yy), 
                "Message checks out: please continue")
    
  } else {
    #Replace each 'multi-space' with a single space
    no_multispace <- gsub("([ ]){1,}", " ", yy)
    #Remove leading spaces, if any
    single_spaced <- gsub("^[ ]", "", no_multispace)
    #Are there any characters besides digits/spaces?
    if (grepl("[^0-9 ]", single_spaced) == TRUE)  {
      #If so, not valid
      ret <- list(FALSE, NA,  "Message can only contain digits (0-9) and spaces")
    } else {
      #If not, then split into a list of words (each one [hopefully] a positive integer)
      word_list <- strsplit(single_spaced, split=" ", fixed=TRUE)
      mmm <- as.integer(unlist(word_list))
      if (xx==3 && length(mmm) != 4) {
        ret <- list(FALSE, NA, "Hashes are exactly four numbers (\'11 22 33 44\')")
      } else {    
        #...and check that each 'word' is in correct range (between 0 and 'imax')
        if (xx==2) imax=256  #Message values go up to prime-1 (0-256)
        if (xx==3) imax=255  #Hash-values must be BYTES (0-255)
        if (any(mmm < 0) || any(mmm > imax)) {
          ret <- list(FALSE, NA, paste("Numbers must be between 0 and", imax))
        } else {
          ret <- list(TRUE, mmm, "The message checks out: please continue")
        } #If no numbers were out of range [0, imax]...
      }   #If hash had the correct length OR message wasn't a hash...
    }     #If all characters were digits or spaces
  }       #If message-type == 2 (i.e., numerical)...
  return(ret)
}

#######################################################
format_hash <- function(x) {
  #From a SHA512 digest, take the first 32 bits and format them as a vector
  #of four integers (each in 0-255 range).
  #INPUT: x == original hash, as raw hex-data
  #OUTPUT: y == length-4 integer vector
  #cat("\nFORMATTING HASH...")
  #cat("RAW: ", x, "\n")
  hh1 <- paste(x[1:4], collapse=" 0x")
  #cat("HH1: ", hh1, "\n")
  hh2 <- paste("0x", hh1, sep="")
  #cat("HH2: ", hh2, "\n")
  hh3 <- strsplit(hh2, " ")
  #cat("HH3: ", paste(hh3, collapse="/"), "\n")
  y <- as.numeric(unlist(hh3))
  return(y)
}

##########################################################
generic_alert <- function(a_title, a_text, a_btn_text, a_btn_color, a_type) {
#Display a generic 'shinyalert'
#a_title: title of alert (along the top)
#a_text: a longer-form alert message (body)
#a_color: color of the 'confirm' button (bottom)
#a_button: Word(s) to put inside the 'confirm' button (bottom)
#a_type: 'type' of alert (EG: "info", "error", "success")
  shinyalert(title=a_title, 
             text=a_text,
             size="s",
             closeOnEsc=TRUE,
             closeOnClickOutside=TRUE,
             html=TRUE,
             showConfirmButton=TRUE,
             showCancelButton=FALSE,
             confirmButtonText=a_btn_text,
             confirmButtonCol=a_btn_color,
             timer=0,
             type=a_type,
             animation=TRUE)
}

##########################################################
#Display the message associated with a help ('Huh?') button 
#INPUTS: title and text 
#OUTPUT: 'shinyalert' object
show_help <- function(tab_title, tab_text) {
  shinyalert(title=tab_title, 
              text=tab_text,
              size="s",
              closeOnEsc=TRUE,
              closeOnClickOutside=TRUE,
              html=TRUE,
              showConfirmButton=TRUE,
              showCancelButton=FALSE,
              confirmButtonText="Got it!",
              confirmButtonCol="orange",
              timer=0,
              type="info",
              animation=TRUE)
}

##########################################################
#Buttons for splash page (e.g., ABOUT, LEGAL, etc...)
show_splash <- function(tab_title, tab_text) {
  shinyalert(title=tab_title, 
             text=tab_text,
             size="s",
             closeOnEsc=TRUE,
             closeOnClickOutside=TRUE,
             html=TRUE,
             showConfirmButton=TRUE,
             showCancelButton=FALSE,
             confirmButtonText="Click anywhere to return",
             confirmButtonCol="blue",
             timer=0,
             type="info",
             animation=TRUE)
}

#######################################################
#Label the 'GO' button, where user applies the key (or keys)
gobutton_label <- function(msg, x) {
  if (msg=="" || is.null(x)) return("Need more input...")
  else if (x==1) return("Apply key!")
  else return("Apply keys!")
}
#######################################################
