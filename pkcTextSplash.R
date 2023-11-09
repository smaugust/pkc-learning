#Text for the usual buttons ('About' and 'Disclaimers') on the splash-page
nerd_title <- HTML('<h2><b><font color=blue>Technical info</font></b></h2')
about_title <- HTML('<h2><b><font color=blue>About this app</font></b></h2')
legal_title <- HTML('<h2><b><font color=blue>Disclaimers</font></b></h2')

nerd_txt <- HTML('<div style="text-align:left;"><font color=black><h4>
 <b><u>Encryption</u>: Pohlig-Hellman</b> exponentiation cipher, with prime 257.

 <br><br><b><u>Hash</u>:</b> The first 32 bits of SHA-512.
 <br><br><b><u>Security</u>: None!</b> Encryption by this app is 
 nothing more than fancy monoalphabetic substitution: 
 <i>it\'s as easy to break as a newspaper\'s \'Daily Cryptogram\'.</i>
 <br>-Why is it so easy to crack? Small prime; few hash bits; 
 weak keys allowed; and no input randomization.
 <br>-These \'low-security\' choices improve speed and convenience
 <i>without sacrificing teaching effectivness.
 </i></h4></font></div>' 
)

about_txt <- HTML('<div style="text-align:left;"><font color=black><h4>
 <b><u>Use</u></b>: This app CAN be used by one person, but it\'s
 INTENDED for use by groups, during \'hands-on\' exercises led
 by a teacher -- the most efficient way to explore the app\'s features.
 <br><br>
 <b><u>Support</u></b>: Supported in part by a grant of time from 
 the MGH-DACCPM Education Committee. 
 <br><br>
 <b><u>Contact</u></b>: Please contact the author, David August 
 (<font color=blue>daugust@mgh.harvard.edu</font>), 
 with questions, suggestions, comments, or ideas for
 collaborating on this (or similar) teaching projects.
 </h4></font>')

legal_txt <- HTML('<div style="text-align:left;"><font color=black><h4>
  <b>This content is solely the responsibility of its author, 
  with no actual or implied endorsement by</b>
  <br>Harvard University, Harvard Medical School, MassGeneral Brigham 
  Corporation, Massachusetts General Hospital (MGH), or
  the MGH Department of Anesthesia, Critical Care, and Pain Medicine.
  
  <br><br><b>This app is available on GitHub as free open-source software (FOSS) for anyone to use, develop, 
  or distribute under a permissive MIT licence.</b>
  <br>-App hosted via Posit on shinyapps.io.
  <br>-The source-code, written in \'R\' (version 4.3.1) for rShiny, is available
  at <font color=blue>https:// github.com / smaugust / pkc-learning</font>.
  </h4></font>')
