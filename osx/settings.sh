
####################################################################################################
#
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
####################################################################################################

# Disable macbook screen when connected to a desktop screen 
#(http://osxdaily.com/2011/09/14/disable-the-internal-screen-on-a-macbook-pro-or-air-in-mac-os-x-10-7-lion/
sudo nvram boot-args="iog=0x0"

# Disable Lion elastic scrolling
# http://osxdaily.com/2012/05/10/disable-elastic-rubber-band-scrolling-in-mac-os-x/
defaults write -g NSScrollViewRubberbanding -int 0

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

####################################################################################################
# Finder
####################################################################################################

# Show the Library folder in Finder
chflags nohidden ~/Library/

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

####################################################################################################
# Dock & SystemUI
####################################################################################################

# Change dock hiding timing
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

####################################################################################################
# iTunes
####################################################################################################

# Disable the Ping sidebar in iTunes
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add ""

# Disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true

# Make ⌘ + F focus the search input in iTunes
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

####################################################################################################
# Mail
####################################################################################################

# Disable send and reply animations in Mail.app
defaults write com.apple.Mail DisableReplyAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal


####################################################################################################
# QuickLook
####################################################################################################
for i in `ls -l plugins`; do ln -s $i ~/Library/QuickLook/$i; done

# Kill affected applications
for app in Dock; do killall "$app" > /dev/null 2>&1; done
echo "Done. Note that some of these changes require a logout/restart to take effect."
