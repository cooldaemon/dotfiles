# For VS Code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
cp ./settings.json ~/Library/Application\ Support/Code/User/settings.json

# For Cursor editor
appId=$(osascript -e 'id of app "Cursor"')
defaults write "$appId" ApplePressAndHoldEnabled -bool false
cp ./settings.json ~/Library/Application\ Support/Cursor/User/settings.json