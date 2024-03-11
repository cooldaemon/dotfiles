# For VS Code
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# For Cursor editor
appId=$(osascript -e 'id of app "Cursor"')
defaults write "$appId" ApplePressAndHoldEnabled -bool false