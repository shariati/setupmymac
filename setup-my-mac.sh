#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

# Source helper functions
source utils/helper.sh

# Function to show header
show_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════╗${NOCOLOR}"
    echo -e "${CYAN}║        Setup My Mac Wizard         ║${NOCOLOR}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NOCOLOR}"
    echo
}

# Main menu to choose setup type
main_menu() {
    show_header
    echo -e "${BLUE}Choose your development environment:${NOCOLOR}\n"
    
    options=(
        "Frontend Development  - React, Vue, Node.js, etc."
        "Backend Development   - Python, Java, Databases, etc."
        "Data Analysis        - Python, R, Jupyter, etc."
        "Custom               - Choose your own tools"
        "Exit"
    )

    # Print options with numbers
    for i in "${!options[@]}"; do
        printf "${GREEN}%3d)${NOCOLOR} %s\n" $((i+1)) "${options[$i]}"
    done

    echo
    read -p "Enter your choice (1-${#options[@]}): " choice

    # Validate input
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#options[@]} ]; then
        echo -e "\n${RED}Invalid input. Please enter a number between 1 and ${#options[@]}.${NOCOLOR}"
        sleep 2
        main_menu
        return
    fi

    # Process selection
    case $choice in
        1)  start_setup "Frontend Development" "./scripts/frontend-setup.sh" ;;
        2)  start_setup "Backend Development" "./scripts/backend-setup.sh" ;;
        3)  start_setup "Data Analysis" "./scripts/data-analysis-setup.sh" ;;
        4)  start_setup "Custom" "./scripts/custom-setup.sh" ;;
        5)  echo -e "\n${GREEN}Thank you for using Setup My Mac Wizard. Goodbye!${NOCOLOR}"
            exit 0 ;;
    esac
}

# Function to handle setup initialization
start_setup() {
    local setup_name=$1
    local script_path=$2
    
    show_header
    echo -e "${YELLOW}Initializing ${setup_name} setup...${NOCOLOR}\n"
    echo -e "${CYAN}This will install and configure the following:${NOCOLOR}"
    
    # Display setup details
    case $setup_name in
        "Frontend Development")
            echo -e "• Node.js and npm\n• Git\n• VS Code\n• Common frontend frameworks\n• Development tools"
            ;;
        "Backend Development")
            echo -e "• Python and pip\n• Databases (PostgreSQL, MongoDB, etc.)\n• Docker\n• Development tools"
            ;;
        "Data Analysis")
            echo -e "• Python and R\n• Jupyter Notebook\n• Data science packages\n• Database tools"
            ;;
        "Custom")
            echo -e "• Choose from all available tools\n• Mix and match as needed"
            ;;
    esac
    
    echo
    read -p "Do you want to continue? (y/N) " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "\n${YELLOW}Starting installation...${NOCOLOR}"
        bash "$script_path"
    else
        echo -e "\n${YELLOW}Setup cancelled. Returning to main menu...${NOCOLOR}"
        sleep 2
        main_menu
    fi
}

# Main execution
check_homebrew  # Ensure Homebrew is installed and updated
main_menu       # Display the main menu
