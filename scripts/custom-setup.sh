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
    "typescript"
    "sass"
    "webpack"
    "eslint"
    "prettier"
    "visual-studio-code"
    "firefox"
    "google-chrome"
    "postman"
    "figma"
    "imagemagick"
    "react-devtools"
    "vue-devtools"
    "lighthouse"

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
    "go"
    "rust"
    "nginx"
    "apache"
    "aws-cli"
    "azure-cli"
    "kubectl"
    "terraform"
    "graphql"

    "#${BLUE} Data Analysis Tools${NOCOLOR}"
    "r"
    "rstudio"
    "jupyter"
    "anaconda"
    "tableau"
    "microsoft-excel"
    "miniconda"
    "apache-spark"
    "hadoop"
    "neo4j"
    "elasticsearch"
    "kibana"
    "tensorflow"
    "pytorch"
    "power-bi"

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
    show_menu "Custom Development Environment Setup" "${tool_names[@]}"
    
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
