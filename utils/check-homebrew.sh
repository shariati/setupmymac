#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NOCOLOR='\033[0m'

# Function to check and install Homebrew
check_homebrew() {
  echo -e "${YELLOW}Checking for Homebrew...${NOCOLOR}"
  if ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew is not installed.${NOCOLOR}"
    while true; do
      read -p "Would you like to install Homebrew now? (y/n): " choice
      case $choice in
        y|Y)
          echo -e "${GREEN}Installing Homebrew...${NOCOLOR}"
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
          if command -v brew &> /dev/null; then
            echo -e "${GREEN}Homebrew installed successfully!${NOCOLOR}"
          else
            echo -e "${RED}Failed to install Homebrew. Exiting.${NOCOLOR}"
            exit 1
          fi
          break
          ;;
        n|N)
          echo -e "${RED}Homebrew is required to run this script. Please install it manually and re-run the script.${NOCOLOR}"
          exit 1
          ;;
        *) echo "Invalid choice. Please enter y or n." ;;
      esac
    done
  else
    echo -e "${GREEN}Homebrew is already installed.${NOCOLOR}"
    echo "Updating Homebrew to the latest version..."
    brew update && brew upgrade
    echo -e "${GREEN}Homebrew updated successfully!${NOCOLOR}"
  fi
}

