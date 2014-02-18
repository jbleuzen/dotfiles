#!/bin/bash

# Global shortcuts
defaults write -g NSUserKeyEquivalents -dict-add "Select Previous Tab" "@~\\U2190"
defaults write -g NSUserKeyEquivalents -dict-add "Select Next Tab" "@~\\U2192"
defaults write -g NSUserKeyEquivalents -dict-add "Précédent" "@\\U2190"
defaults write -g NSUserKeyEquivalents -dict-add "Suivant" "@\\U2192"
defaults write -g NSUserKeyEquivalents -dict-add "Sélectionner l'onglet précédent" "@~\\U2190"
defaults write -g NSUserKeyEquivalents -dict-add "Sélectionner l'onglet suivant" "@~\\U2192"

# Finder shortcuts
defaults write com.apple.Finder NSUserKeyEquivalents -dict-add "Masquer la barre latérale" "@\$d"
defaults write com.apple.Finder NSUserKeyEquivalents -dict-add "Afficher la barre latérale" "@\$d"
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Masquer la barre latérale" "@\$d"
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Afficher la barre latérale" "@\$d"

### With Mavericks you must clear prefs cache
killall cfprefsd

### Restart Finder
killall Finder
