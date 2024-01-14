#!/bin/bash

# Install brew if not installed
if ! command -v brew &> /dev/null
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install duti if not installed
if ! command -v duti &> /dev/null
then
  echo "Installing duti..."
  brew install duti
fi

# Install curl if not installed
if ! command -v curl &> /dev/null
then
  echo "Installing curl..."
  brew install curl
fi

# Path to the Visual Studio Code application
VSCODE_APP='com.microsoft.VSCode'
FILE_TYPES_FILE='https://raw.githubusercontent.com/lucasilverentand/vscode-as-default/main/languages.txt'

# Get the content of the file
echo "Fetching file types from GitHub..."
FILE_TYPES_CONTENT=$(curl -s $FILE_TYPES_FILE)

echo "Setting Visual Studio Code as the default application:"

# Read the file content fetched from the URL
while IFS= read -r line
do
  # Remove the leading dot from the file extension
  EXTENSION="${line#.}"

  echo -n "  .$EXTENSION > "
  
  # Set Visual Studio Code as the default application for the file extension
  duti -s $VSCODE_APP .$EXTENSION all
  # add checkmark after previous echo without new line
  echo -e "\xE2\x9C\x94"
done <<< "$FILE_TYPES_CONTENT"
