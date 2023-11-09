#When user presses a 'Huh?' button for help, one of these 
#messages will appear (as a 'shinyalert')

explain_intro_text <- '<div style="text-align:left;"><h4><b><font color=black>
    Click the <font color=green>\'Huh?\'</font> buttons for help navigating through
    the app, and for tips.
    <br><br>Tabs (top of screen) cover different topics, each with
    its own navigation and help buttons.
    </font></b></h4></div>'

explain_translate_text <- HTML('<div style="text-align:left;"><b><font color=black>
    Whatever you type, computers translate it into numbers.
    <br><br>Here, you can translate from English to numbers, or vice-versa.
    <br><br><u>NOTE</u>: Any number that doesn\'t correspond to a   
    \'printable\' character will be translated as \u2B24.
    </font></b></div>')

explain_hash_text <- HTML('<div style="text-align:left;"><b><font color=black>
  A HASH is a short <i>fingerprint</i> of your message.
  <br><br>Here, you can see the hash of whatever you type.
  (The hash actually has 64 numbers, but we just show the first four here.)
  
  <br><br><u>Example</u>: Storing a list of passwords is a terrible idea, since 
  it could be hacked or stolen.  Instead, computers store lists of <i>hashed</i>  
  passwords.  For fun, compare the hashes of similar passwords 
  (like</b>
  <style="font-family:Courier,Georgia,Serif;"))>dietcoke-2023-1</style> <b>and</b> 
  <style="font-family:Courier,Georgia,Serif;"))>dietcoke-2023-2</style>)<b>. 
  Their hashes look very different!
  </font></b></div>')

explain_genkey_text <- HTML('<div style="text-align:left;"><b><font color=black>
      Before anything exciting can happen with public-key crypto, you need TWO keys:

      <br><br><li>A <font color=red>private</font> key to keep SECRET</li>
      <li>A <font color=green>public</font> key to SHARE with everyone</li>
      <br>Use the slider to pick your secret key, and the app will show
      your public key.
      <br><br><font color=blue>TIP:</font> Write \'em down so you won\'t have to remember. 
      </font><b></div>')

explain_message_text <- HTML('<div style="text-align:left;"><b><font color=black>
      Messages can be written in regular English or as a list of numbers
      (for hashes and scrambled messages).  
      <br><br><font color=blue>TIP</font>: Always hit 
      <font color=brown>\'CONFIRM\' </font> after typing (or changing)  
      your message.  This <i>double-checks</i> its format and <i>stores</i> the new data. 
      <br><br><font color=blue>TIP</font>: Try short messages (\'hello!\') at first. 
      </font><b></div>')

explain_use1key_text <- HTML('<div style="text-align:left;"><b><font color=black>
  With 1 key, you can scramble or unscramble a message; \'sign\' a message
  (or its hash); or verify a signature. 
  
  <br><br>Make a choice; provide a key; and then use the <font color=green>
  GO!</font> tab to see what happens.

  <br><br><u>TIP</u>: Hit <font color=brown>\'CONFIRM\' </font> after entering 
  (or changing) a key to <i>double-check</i> its format and <i>update</i> its value.
  
  <br><br><u>TIP</u>: <i>Work with a partner</i>: some activities just require 
  your key, but others require someone else\'s (public) key.
  </font></b></div>')

explain_use2keys_text <- HTML('<div style="text-align:left;"><b><font color=black>
  Here, you use TWO keys at once to get <u>privacy</u> 
  (scrambling & unscrambling) and <u>authentication</u> 
  (creating & verifying digital signatures).

  <br><br>After choosing an activity and entering keys, see what happens  
  using the <font color=green>GO!</font> tab.
  
  <br><br><u>TIP</u>: <font color=brown>\'CONFIRM\' </font> your keys after entering 
  (or changing) them, to <i>double-check</i> their format and <i>store</i> new values.
  
  <br><br><u>TIP</u>: Work with a partner (who also has two keys).
  </font></b></div>')
 
explain_apply_text <- HTML('<div style="text-align:left;"><b><font color=black>
  See what happens when key(s) are applied to messages and hashes.

  <br><br>If you\'re <i>decrypting</i>, the result will be translated into English
  (where \'\u2B24\' means non-printable).
  
  <br><br>If you\'re <i>verifying a hash</i>, the result will be compared to 
  a hash of the decrypted message -- sounds confusing, but
  happens automatically.
  
  <br><br><u>TIP</u>: <font color=blue>Two inputs are needed:</font> message & key.
  If you\'re not seeing anything, did you \'CONFIRM\' them both?
  </font></b></div>')
