#
# AppleScript to quit the current front app after a warning. Useful to remap CMD+Q and stop quitting app by mistake
#
# 1. Open AppleScript
# 2. Past this file
# 3. Save as `~/.quit_front_app.scpt`
# 4. Run `osascript ~/.quit_front_app.scpt`
# 5. There is no 5
#
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
	display dialog "Quit?"
end tell
tell application frontApp to quit
