#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NOCOLOR='\033[0m'

# Available tools for frontend development
FRONTEND_TOOLS=(
  "NodeJS:node"
  "Yarn:yarn"
  "Webpack:webpack"
  "Live Server:live-server"
  "React (create-react-app):create-react-app"
  "Vue CLI:@vue/cli"
  "Angular CLI:@angular/cli"
  "Jest:jest"
  "Cypress:cypress"
  "ESLint:eslint"
  "Prettier:prettier"
  "Postman:postman"
)

# Function to display the initial list of tools
display_tools() {
  echo -e "${CYAN}Frontend Development Setup:${NOCOLOR}"
  echo "Here is the list of recommended tools:"
  local index=1
  for tool in "${FRONTEND_TOOLS[@]}"; do
    echo "$index. ${tool%%:*}"
    index=$((index + 1))
  done
}

# Function to allow the user to select/deselect tools
select_frontend_tools() {
  echo -e "\n${YELLOW}Modify the list of tools by selecting/deselecting options.${NOCOLOR}"
  
  local selected_tools=()
  for tool in "${!FRONTEND_TOOLS[@]}"; do
    while true; do
      read -p "Include $tool? (y/n): " choice
      case $choice in
        y|Y)
          selected_tools+=("${FRONTEND_TOOLS[$tool]}")
          break
          ;;
        n|N)
          echo "Skipping $tool."
          break
          ;;
        *)
          echo "Invalid choice. Please enter y or n."
          ;;
      esac
    done
  done

  echo "${selected_tools[@]}"
}

# Function to confirm the final choice
confirm_selection() {
  local tools_to_install=("$@")
  
  echo -e "\n${CYAN}Final list of tools selected for installation:${NOCOLOR}"
  for tool in "${tools_to_install[@]}"; do
    echo "- $tool"
  done

  while true; do
    read -p "Do you want to proceed with the installation? (y/n): " confirm
    case $confirm in
      y|Y) return 0 ;;
      n|N)
        echo -e "${RED}Installation canceled by the user.${NOCOLOR}"
        exit 0
        ;;
      *)
        echo "Invalid choice. Please enter y or n."
        ;;
    esac
  done
}

# Function to install tools
install_frontend_tools() {
  local tools_to_install=("$@")
  
  if [ ${#tools_to_install[@]} -eq 0 ]; then
    echo -e "${RED}No tools selected for installation. Exiting.${NOCOLOR}"
    exit 1
  fi

  echo -e "${YELLOW}Installing selected tools for Frontend Development...${NOCOLOR}"
  for tool in "${tools_to_install[@]}"; do
    if [[ "$tool" == "postman" ]]; then
      brew install --cask "$tool"
    elif [[ "$tool" =~ ^@ ]]; then
      npm install -g "$tool"
    else
      brew install "$tool" || npm install -g "$tool"
    fi
    echo -e "${GREEN}Installed: $tool${NOCOLOR}"
  done

  echo -e "${GREEN}Frontend Development setup complete!${NOCOLOR}"
}

# Main execution
display_tools
selected_tools=$(select_frontend_tools)
confirm_selection ${selected_tools[@]}
# install_frontend_tools ${selected_tools[@]}
