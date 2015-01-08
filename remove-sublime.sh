#!/bin/bash

set -x

killall 'Sublime Text'
brew cask uninstall sublime-text
brew cask uninstall sublime-text3
rm -f /usr/local/bin/subl
sudo rm -rf /Applications/Sublime*
rm -rf ~/Applications/Sublime*
rm -rf ~/Library/Application\ Support/Sublime*
