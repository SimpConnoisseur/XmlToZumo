function [song, numOfParts, numOfNotes] = simplifyxml(f)
numOfParts = 0;
numOfMeasure = 0;
score = readstruct(f,"StructSelector","/score-partwise");
try     %finds the number of parts there are in the score
    for i = 1:10
        score.part(i);
        numOfParts = numOfParts + 1;
    end
catch
end
numOfNotes = ones(numOfParts,1); %instantiates number of notes for all the parts as one
try     %finds the number of measures in the score
for j = 1:1000
     score.part(1).measure(j);
     numOfMeasure = numOfMeasure + 1;
end
catch
end
array = string(ones(10000,10,numOfParts));      %instantiates the string array that uses the data
for i = 1:numOfParts    %repeats for every part in the score
    array(:,1,i) = 1:10000;
    part = score.part(i);
    for j = 1:numOfMeasure      %repeats for every measure in the score
    measure = part.measure(j);
    try     %finds if there was a change in dynamics in that measure
        array(numOfNotes(i) + 1,8,i) = floor(measure.direction(1).sound(1).dynamicsAttribute/30) + 10;
    catch
    end
    try     %finds if there was a change in tempo that measure
        array(numOfNotes(i) + 1, 9,:) = round(measure.direction(1).direction_type(1).metronome(1).per_minute(1));
    catch
    end
    try
        for k = 1:100       %checks all the notes in a measure
            p = measure.note(k);
            try     %checks for grace notes, just skips the note if it exists
                if p.grace == ""
                else
                    p.weird     %meant to throw an error
                end
            catch
                try         %writes down the "type" or length of the note
                    array(numOfNotes(i),5,i) = p.type;
                catch
                end
                try
                     n = p.pitch;
                     array(numOfNotes(i),1,i) = numOfNotes(i);      %writes down the notes position
                     array(numOfNotes(i),2,i) = n.step;             %writes down the note step (A, B, C, D, ...)
                     array(numOfNotes(i),3,i) = n.octave;           %writes down the note octave (so for C3 it would be 3)
                     try
                         array(numOfNotes(i),6,i) = n.alter;        %writes -1 for flat, 1 for sharp
                     catch
                         array(numOfNotes(i),6,i) = "0";            %writes 0 for natural
                     end
                     try        %meant to find tuplets and use it (like triplets)
                         normcount = p.time_modification.normal_notes;      %this is the normal count (so 2 eighth notes would be one quarter note)
                         actcount = p.time_modification.actual_notes;       %this is the actual count (so actually 3 eighth notes would be one quarter note for a triplet)
                         array(numOfNotes(i),4,i) = double(actcount)/double(normcount);  %actual count divided by normal count gives the value the time normal should be multiplied by to give the actual time for these notes
                     catch
                     end
                 catch
                     array(numOfNotes(i),2,i) = "rest"; %this writes if the note is a rest
                     array(numOfNotes(i),3,i) = "";
                end
            if array(numOfNotes(i), 5, i) == "whole" %these give the note a number based on the type of note
            array(numOfNotes(i), 5, i) = "1";
            end

            if array(numOfNotes(i), 5, i) == "half"
                array(numOfNotes(i), 5, i) = "2";
            end
            if array(numOfNotes(i), 5, i) == "quarter"
                array(numOfNotes(i), 5, i) = "4";
            end
            if array(numOfNotes(i), 5, i) == "eighth"
                array(numOfNotes(i), 5, i) = "8";
            end
            if array(numOfNotes(i), 5, i) == "16th"
                array(numOfNotes(i), 5, i) = "16";
            end
            if array(numOfNotes(i), 5, i) == "32nd"
                array(numOfNotes(i), 5, i) = "32";
            end
                try     %writes if the note is dotted or not
                    if p.dot == ""
                    array(numOfNotes(i),10,i) = "dot";
                    else
                    end
                catch
                end
                numOfNotes(i) = numOfNotes(i) + 1; %goes to the next note
            end
        end
    catch
    end
    end
end
song = array;
end



