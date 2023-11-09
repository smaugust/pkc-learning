# pkc-learning
Teaching material about public key cryptography

OVERVIEW
========
This repository holds a tool for learning about 'public-key cryptography' (PKC).
It's a basic, non-mathematical introduction for those who are not necessarily
in technical fields like engineering, computers science, or math. (For instance,   
it was initially developed for medical professionals, who deal with protected, 
private health-information on a regular basis.)

The material is designed as an "app", written in R-language (using rShiny).
The source-code is available here, and the app can also be found at:
o4z326-david-august.shinyapps.io/learn-pkcrypto/

While it can be used for self-paced, individual learning, the app works more efficiently
as part of group teaching-sessions (e.g., a lecture which includes some hands-on exercises,
where the instructor can guide learners through various features of the app).

TECHNICAL
=========
As models, this app uses the 'Pohlig-Hellman' exponentiation cipher (with prime = 257) for 
encryption and the first 32 bits of a SHA-512 digest for hashes. The resulting system 
does NOT provide secure encryption(!) -- it's as easy to break as a newspaper cryptogram.
Specific security issues include the small prime; lack of input randomization; acceptance of some 
weak keys; and relatively few hash bits.  The goal here is not to achieve 'security', but rather 
to communicate fundamental ideas about encryption, authentication, and hashing simply qnd quickly. 

CONTENTS
========
(1) README.md ... This file

(2) R-language source-codes for a public-key crypto learning "app".
      (a) app.R  -- main file
      (b) pkcUI.R -- user-interface
      (c) pkcServer.R -- server
      (d) pkc-utils.R -- various support routines (input validation, encryption, etc.)
      (e) Messages:
          -- pkcTextHuh.R (Help/navigation buttons, called 'Huh?' buttons in the app)
          -- pkcTextLearn.R (Learning points for each 'tab')
          -- pkcTextSplash.R (Spash-page info: about, legal, etc.)
      (f) Files for each "Tab":
          -- pkc-splash.R (Landing-page) 
          -- pkc-message.R (Enter a message, formatted as "English", "Numbers", or "Hash") 
          -- pkc-hash.R (Calculate a hash, given an ASCII-string input) 
          -- pkc-translate (Show the 'translation' between integers and ASCII/UTF-8)
          -- pkc-genkey.R (Choose a private key; and the app calculates the corresponding public key) 
          -- pkc-1key.R (Set up encryption/authentication w/ ONE key)
          -- pkc-2keys.R (Set up encryption/authentication w/ TWO keys) 
          -- pkc-go.R ("Action" tab -- actually do the encryption / authentication)
          

