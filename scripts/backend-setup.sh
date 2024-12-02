#!/bin/bash

# Source helper functions
source ../utils/helper.sh

# Array to store selected tools
selected_tools=()

# Array to store tool names in order
tool_names=(
    "python3"
    "pip3"
    "postgresql"
    "mysql"
    "mongodb-community"
    "redis"
    "docker"
    "docker-compose"
    "postman"
    "git"
    "visual-studio-code"
    "iterm2"
    "pgadmin4"
    "dbeaver-community"
    "go"
    "rust"
    "nginx"
    "apache"
    "aws-cli"
    "azure-cli"
    "kubectl"
    "terraform"
    "graphql"
)

# Initialize selected_tools with all tools by default
selected_tools=("${tool_names[@]}")

# Check homebrew installation
check_homebrew

# Selection process
while true; do
    clear
    show_menu "Backend Development Tools Setup" "${tool_names[@]}"
    
    read -p "Enter a number (or press ENTER to finish): " choice
    
    # If empty input, break the loop
    if [[ -z "$choice" ]]; then
        break
    fi
    
    # Handle the selection and continue the loop
    handle_selection "$choice" "${tool_names[@]}"
done

# Install tools
confirm_installation "${selected_tools[@]}" || exit 0
install_tools "${selected_tools[@]}" || exit 1
post_install_setup "${selected_tools[@]}" || exit 1
show_completion_message "${selected_tools[@]}"
