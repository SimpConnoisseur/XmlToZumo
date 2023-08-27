function output = xmltozumo(file)
[song, numOfParts, numOfNotes] = simplifyxml(file);
output = makezumo(song,numOfParts,numOfNotes,120);