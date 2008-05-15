#!/bin/sh
`osascript << EOS
tell application "Firefox"
  activate
end tell

tell application "System Events"
  if UI elements enabled then
    key down command
    keystroke "r"
    key up command
  end if
end tell

tell application "Vim"
  activate
end tell
EOS`
