#!/bin/sh
echo "Download and Install Homebrew App Manager"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Install JQ JSON processor for shell via Homebrew"
brew install jq
