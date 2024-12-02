#!/bin/bash

# Source helper functions
source utils/helper.sh

# Array to store selected tools
selected_tools=()

# Array to store tool names in order, grouped by category
tool_names=(
    "#${BLUE} Frontend Tools${NOCOLOR}"
    "node"
    "yarn"
    "nvm"
    "visual-studio-code"
    "firefox"
    "google-chrome"
    "postman"
    "figma"
    "imagemagick"

    "#${BLUE} Backend Tools${NOCOLOR}"
    "python3"
    "pip3"
    "postgresql"
    "mysql"
    "mongodb-community"
    "redis"
    "docker"
    "docker-compose"
    "iterm2"
    "pgadmin4"
    "dbeaver-community"

    "#${BLUE} Data Analysis Tools${NOCOLOR}"
    "r"
    "rstudio"
    "jupyter"
    "anaconda"
    "tableau"
    "microsoft-excel"
    "miniconda"

    "#${BLUE} Common Tools${NOCOLOR}"
    "git"
)

# Initialize selected_tools with all tools by default (excluding category headers)
for tool in "${tool_names[@]}"; do
    if [[ ! $tool == \#* ]]; then
        selected_tools+=("$tool")
    fi
done

# Check homebrew installation
check_homebrew

# Selection process
while true; do
    clear
    show_menu "Custom Development Environment Setup" tool_names selected_tools
    
    read -p "Enter a number (or press ENTER to finish): " choice
    handle_selection "$choice" tool_names selected_tools || [ $? -eq 1 ] && break
done

# Install tools
confirm_installation selected_tools || exit 0
install_tools selected_tools || exit 1
post_install_setup selected_tools || exit 1
show_completion_message selected_tools
