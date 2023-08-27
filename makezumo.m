function output = makezumo(array,numOfParts,numOfNotes,tempo)
zumoParts = string(char(zeros(numOfParts,1) + 84)) + tempo + " "; %instantiates an array that will hold all the parts as respective strings
for i = 1:numOfParts
    temp = "";
    temp1 = "";
    temp2 = "1";
    temp3 = "";
    temp4 = "";
    for j = 1:numOfNotes(i)
         if array(j,9,i) == "1"
         else
             tempo = array(j,9,i);
             zumoParts(i) = zumoParts(i) + " T" + string(tempo) + " ";
         end
         if array(j,8,i) == "1" || array(j,8,i) == "-1"
         else
             if double(array(j,8,i)) <= 8
                 zumoParts(i) = zumoParts(i) + " V8 ";
             elseif double(array(j,8,i)) >= 15
                 zumoParts(i) = zumoParts(i) + " V15 ";
             else
                zumoParts(i) = zumoParts(i) + " V" + string(array(j,8,i)) + " ";
             end
         end
         if array(j,4,i) == temp2
         else
         temp2 = array(j,4,i);
         zumoParts(i) = zumoParts(i) + " T" + string(round(double(tempo) * double(temp2))) + " ";
         end
         if temp1 == array(j,5,i) 
         else
         zumoParts(i) = zumoParts(i) + " L" + array(j,5,i) + " ";
         temp1 = array(j,5,i);
         end
        if array(j,2,i) == "rest"
            zumoParts(i) = zumoParts(i) + "R";
            temp4 = "R";
        else
            if array(j,3,i) == temp
                temp4 = char(char(array(j,2,i)) + 32);
                zumoParts(i) = zumoParts(i) + temp4;
            else
            zumoParts(i) = zumoParts(i) + " O"  + array(j,3,i);
            temp4 = " " + char((char(array(j,2,i)) + 32));
            zumoParts(i) = zumoParts(i) + temp4;
            temp = array(j,3,i);
            end
            if array(j,6,i) == "1"
                temp4 = temp4 + "+";
                zumoParts(i) = zumoParts(i) + "+";
            end
            if array(j,6,i) == "-1"
                temp4 = temp4 + "-";
                zumoParts(i) = zumoParts(i) + "-";
            end
        end
        if array(j,10,i) == "dot"
            zumoParts(i) = zumoParts(i) + ".";
        end
    end
end
output = zumoParts;