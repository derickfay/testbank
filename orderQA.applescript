set answersPerQuestion to 5

tell application "Numbers"
	set l to {}
	tell table "Questions" of sheet 1 of document 1
		-- get the existing order & randomize it
		repeat with i from 2 to count of cells of column "Question Order"
			set l to l & value of cell i of column "Question Order"
		end repeat
		set m to my randomizedSublist(l, count of l)
		
		-- replace the existing order with the new random order
		repeat with j from 1 to count of m
			set value of cell (j + 1) of column "Question Order" to item j of m
		end repeat
		
		sort by column "Question Order"
	end tell
	
	set totalQuestions to (count of cells of column "Question ID" of table "Questions" of sheet 1 of document 1) - 1
	
	tell table "Answers" of sheet 1 of document 1
		set baseNum to 1
		repeat with n from 1 to totalQuestions
			set l to {}
			
			if value of cell (1 + baseNum) of column "Random" is "y" then
				-- if the questions has answers in a fixed order, it gets skipped				
				repeat with i from (1 + baseNum) to (answersPerQuestion + baseNum)
					set l to l & value of cell i of column "Answer Order"
				end repeat
				set m to my randomizedSublist(l, count of l)
				repeat with j from (1 + baseNum) to (answersPerQuestion + baseNum)
					set value of cell j of column "Answer Order" to item (j - baseNum) of m
				end repeat
			end if
			
			set baseNum to baseNum + answersPerQuestion
		end repeat
		sort by column "Answer Order"
		sort by column "Question Order"
	end tell
	
end tell

on randomizedSublist(mainList, maxCount)
	set sublist to {} as list
	repeat with x from 1 to maxCount
		set oneItem to some item of mainList
		repeat until sublist does not contain oneItem
			set oneItem to some item of mainList
		end repeat
		set end of sublist to oneItem
	end repeat
	return sublist
end randomizedSublist