#!/bin/bash

# Install rbenv and ruby-build
brew install rbenv
brew install ruby-build

# Add rbenv to bash so that it loads every time you open a Terminal
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
source ~/.zshrc

# Install Ruby
rbenv install 3.2.3
rbenv global 3.2.3
ruby -v

# Install bundler
gem install bundler

# Install Fastlane
brew install fastlane