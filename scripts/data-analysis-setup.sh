#!/bin/bash

# Source helper functions
source utils/helper.sh

# Array to store selected tools
selected_tools=()

# Array to store tool names in order
tool_names=(
    "python3"
    "pip3"
    "r"
    "rstudio"
    "jupyter"
    "anaconda"
    "postgresql"
    "mysql"
    "tableau"
    "visual-studio-code"
    "git"
    "docker"
    "dbeaver-community"
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
)

# Initialize selected_tools with all tools by default
selected_tools=("${tool_names[@]}")

# Check homebrew installation
check_homebrew

# Selection process
while true; do
    clear
    show_menu "Data Analysis Tools Setup" tool_names selected_tools
    
    read -p "Enter a number (or press ENTER to finish): " choice
    handle_selection "$choice" tool_names selected_tools || [ $? -eq 1 ] && break
done

# Install tools
confirm_installation selected_tools || exit 0
install_tools selected_tools || exit 1
post_install_setup selected_tools || exit 1
show_completion_message selected_tools
