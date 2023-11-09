#When user presses a 'Huh?' button for help, one of these 
#messages will appear (as a 'shinyalert')


learn_intro_text <- HTML('<div style="text-align:left;"><b><font color=black>
    <font color=purple>LEARN</font> buttons answer questions like...
    <br><br>How do computers <font color=blue>turn text into numbers</font>?
    <br>What\'s a <font color=blue>hash</font>, and how is it used?
    <br>What\'s <font color=blue>public-key</font> crypto?
    <br>How do I <font color=blue>scramble</font> (or unscramble) a message?
    <br>How do I <font color=blue>authenticate</font> (\'digitally sign\') something?
    </font><b></div>'
)  

learn_translate_text <- HTML('<div style="text-align:left;"><b><font color=black>
    Going from keyboard characters to numbers is called ENCODING, and the
    reverse is DECODING.
    <br><br>This is <font color=red>NOT</font> \'encryption\' 
    -- it\'s just another way to represent data.
    <br><br>This is <font color=red>NOT</font> a \'secret code\'
    -- it\'s a well-known, open, public code (UTF-8) used by many computers 
    and devices everywhere in the world.
    </font></b></div>')

learn_hash_text <- HTML('<div style="text-align:left;"><b><font color=black>
  A hash, like a <i>fingerprint</i> of your message, is:
  <li>short,</li>
  <li>unique,</li>
  <li>unpredictable,</li>
  <li>one-way, and</li>
  <li>always the same size, however long the message.</li>
  <br><br><u>One-way</u>. It\'s easy get a hash from a messsage, 
  but nearly impossible to re-create the original 
  from its hash.
  <br><br><u>Short & unique</u>. No matter how long the input, its
  fingerprint is always the same size (short).  This makes hashes useful for
  <i>digital signatures</i>: instead of signing 
  a gigantic file (like a whole TV episode), just sign its hash.
  </font></b></div>')

learn_genkey_text <- HTML('<div style="text-align:left;"><b><font color=black>
  <font color=blue>Traditional (symmetric) crypto:</font> you have ONE key, which   
  is the same as your partner\'s.  
  <font color=blue>Public-key (asymmetric) crypto:</font> you have TWO keys, which
  differ from each other and from your parter\'s.

  <br><br>Your two keys (<font color=green>public</font> and 
  <font color=red>private</font>) 
  are opposites: one scrambles; the other unscrambles; 
  and the order doesn\'t matter.
  
  <br><br>Anyone can send you a scrambled message 
  (w/ your <font color=green>public</font> key),
  but only you can unscramble it 
  (w/ your <font color=red>private</font> key).
  You & a stranger can talk privately <i>without</i>...
  <br>...agreeing on a key beforehand,</li> 
  <br>...sharing a key over the (unsafe!) Internet, or</li> 
  <br>...meeting them in-person to exchange a key.</li>
  </font><b></div>')  

learn_message_text <- HTML('<div style="text-align:left;"><b><font color=black>
      Computers represent whatever you type as numbers.
      For example, the letter <font color=blue>\'z\'</font> 
      is encoded as the number <font color=blue>122</font>.      
      
      <br><br>Confusingly, though, 122 can be written in different ways:
      <font color=blue>\'7A\'</font> 
      in base-16 (hexadecimal); or <font color=blue>\'01111010\'</font>
      in base-2 (binary); or <font color=blue>172</font> in base-8 (octal);
      or <font color=blue>\'MTIy\'</font> in base-64.
      
      <br><br>These weird-looking mixtures of letters & numbers are sometimes
      <i>mistaken</i> for encrypted data.  Don\'t be fooled.
      
      <br><br>For simplicity, this app sticks to
      normal base-10 (decimal): <i>122 just means 122!</i>
      </font><b></div>')

learn_use1key_text <- HTML('<div style="text-align:left;"><b><font color=black>
  <br><br>To scramble (\'encrypt\') a message to someone, 
  or verify someone\'s signature, 
  use <i>their <font color=green>public</font></i> key.
  
  <br><br>To unscramble (\'decrypt\') a message from someone, or \'sign\' 
  a message to them, use <i>your <font color=red>private</font></i> key.  
  
  <br><br>The same key can be used in different ways, 
  depending on <u>who initiates</u> the conversation. If YOU start, you 
  use someone else\'s public key to <i>scramble</i> a message for them. 
  But if THEY start, you could use that same key to <i>verify</i> 
  their signature on the message to you.
  </font></b></div>')

learn_use2keys_text <- HTML('<div style="text-align:left;"><b><font color=black>
  With TWO keys, one provides <u>privacy</u> 
  (scrambling a message) and the other provides <u>authenticity</u> 
  (guaranteeing that only one person could have sent it).  
  
  <br><br><u>For fun</u>: see your <font color=red>private</font> and 
  <font color=green>public</font> keys work as opposites by using BOTH 
  on the same message: you\'ll get back whatever you started with!</li>
  
  <br><br><u>For real</u>: send your partner a <i>scrambled & signed</i> message
  (with their public key & your private key). Then, have them 
  <i>unscramble</i> it (with their private key) and <i>verify</i> that you 
  sent it (with your public key).
  </font></b></div>')
 
learn_apply_text <- HTML('<div style="text-align:left;"><b><font color=black>
  <u>Speed</u> is important: <i>nobody wants to wait for crypto!</i>
  
  <br><br>Public-key crypto is too slow for big files, but hashing a file 
  of any size is always fast.  Instead of using private keys to sign
  a <u>whole message</u>, they can be used on its <u>(small-sized) hash</u> instead:

  <br><br>-Encrypt message and sign its hash;  
  <br>-Enter the whole result (scrambled message + signed hash)
  as a new MESSAGE, using copy & paste;
  <br>-Your partner can <u>decrypt & verify</u> it (last 2-KEY option). 
  </font></b></div>')
