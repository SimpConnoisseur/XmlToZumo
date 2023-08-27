function output = xmltozumofinal(file)
[song, numOfParts, numOfNotes] = xml2zumo(file);
output = makezumo(song,numOfParts,numOfNotes,120);
