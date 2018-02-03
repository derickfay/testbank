set startingNumber to 1

tell application "Numbers"
	set currentQNumber to startingNumber
	set outputString to ""
	set answerTable to table "Answers" of sheet 1 of document 1
	tell table "Questions" of sheet 1 of document 1
		repeat with i from 2 to count of rows
			if (value of cell i of column "Include?" is "y") then
				
				set outputString to outputString & currentQNumber & ". " & value of cell i of column "Question" & " "
				repeat with j from 2 to count of rows of answerTable
					if (value of cell i of column "Question ID") is (value of cell j of column "Question ID" of answerTable) and (value of cell j of column "Right?" of answerTable is "x") then
						set outputString to outputString & "
	" & (value of cell j of column "Answer Order" of answerTable) & " " & (value of cell j of column "Answer" of answerTable)
					end if
				end repeat
				set outputString to outputString & "
"
				set currentQNumber to currentQNumber + 1
				
			end if
		end repeat
	end tell
end tell

set resultFile to (choose file name with prompt "Save Answer Key File" default name "Answer Key") as text
if resultFile does not end with ".txt" then set resultFile to resultFile & ".txt"
do shell script "echo " & quoted form of outputString & " > " & quoted form of POSIX path of resultFile
