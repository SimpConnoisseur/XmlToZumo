# XmlToZumo
In order to use this code you will need to download it onto MATLAB and any other tools required to run this code. (I believe you need a MATLAB tool that allows you to read XML files as a Structure)

How to use:

          You need to call the xmltozumofinal function with the file name in the function

          Example: xmltozumo("Example.xml")
          
          Click find variable in Matlab and open up the string array that contains the output of the xmltozumo function

          The output should be a n x 1 string array, with n representing the number of parts

          Each ith row represents the ith part
          
          Copy whichever part you would like to use by clicking on the string and then pressing ctrl + A
          
          You can paste this into the Arduino IDE after buzzer.play(F("your string"));

Things to note:

          The default tempo is 120, if the xml file does not provide one (I may provide an option to change it in the future)

          I may decide to add staccato notes, however I have not yet added them

Errors may occur if:

          The xml file is not downloaded from Musescore 3.1
          
          There are parts that have more that one line
          
          There are notes faster than a 64th
          
          You try to use an mxl file (in that case extract the file)
          
