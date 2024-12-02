#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NOCOLOR='\033[0m'

# Function to install a tool
install_tool() {
  local tool=$1
  echo -e "${YELLOW}Checking for $tool...${NOCOLOR}"

  if brew list "$tool" &> /dev/null || brew list --cask "$tool" &> /dev/null; then
    echo -e "${GREEN}$tool is already installed.${NOCOLOR}"
    while true; do
      read -p "Would you like to update $tool? (y/n): " choice
      case $choice in
        y|Y)
          echo -e "${YELLOW}Updating $tool...${NOCOLOR}"
          brew upgrade "$tool" || brew upgrade --cask "$tool"
          echo -e "${GREEN}$tool updated successfully!${NOCOLOR}"
          break
          ;;
        n|N)
          echo -e "${YELLOW}Skipping update for $tool.${NOCOLOR}"
          break
          ;;
        *)
          echo "Invalid choice. Please enter y or n."
          ;;
      esac
    done
  else
    echo -e "${YELLOW}Installing $tool...${NOCOLOR}"
    brew install "$tool" || brew install --cask "$tool"
    if brew list "$tool" &> /dev/null || brew list --cask "$tool" &> /dev/null; then
      echo -e "${GREEN}$tool installed successfully!${NOCOLOR}"
    else
      echo -e "${RED}Failed to install $tool.${NOCOLOR}"
    fi
  fi
}

# Function to batch install tools
install_tools_batch() {
  local tools=("$@")
  echo -e "${YELLOW}Starting batch installation of tools...${NOCOLOR}"

  for tool in "${tools[@]}"; do
    install_tool "$tool"
  done

  echo -e "${GREEN}Batch installation complete!${NOCOLOR}"
}
