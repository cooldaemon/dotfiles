#!/bin/sh
#1.0 -- 2004.04.22 
targetDir=`osascript << EOS
tell application "Finder"
	set theLocation to insertion location
	
	if class of theLocation is not in {folder, disk} then
		set theLocation to folder of theLocation
	end if
	
	if exists Finder window 1 then
		if (target of Finder window 1 as Unicode text) is (theLocation as Unicode text) then
			set theSelection to selection
			if theSelection is not {} then
				set theSelection to item 1 of theSelection
				if (theSelection as Unicode text) ends with ":" then
					set theLocation to theSelection
				else
					set theLocation to folder of theSelection
				end if
			end if
		end if
	end if
	
	set theLocation to theLocation as alias
end tell

set theLocation to POSIX path of theLocation
return theLocation
EOS`

cd "$targetDir"
echo $PWD
