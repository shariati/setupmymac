#!/bin/bash
set -u # Exit on unbound variables

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

# Source helper functions
source utils/helper.sh
source utils/updater.sh

# Function to show header
show_header() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════╗${NOCOLOR}"
    echo -e "${CYAN}║        Setup My Mac Wizard         ║${NOCOLOR}"
    echo -e "${CYAN}╚════════════════════════════════════╝${NOCOLOR}"
    echo
}

# Function to start specific setup
start_setup() {
    local setup_name="$1"
    local setup_script="$2"

    # Check if script exists
    if [ ! -f "$setup_script" ]; then
        echo -e "${RED}Error: Setup script '$setup_script' not found.${NOCOLOR}"
        sleep 2
        main_menu
        return
    fi

    # Check if script is executable
    if [ ! -x "$setup_script" ]; then
        echo -e "${YELLOW}Making setup script executable...${NOCOLOR}"
        chmod +x "$setup_script"
    fi

    # Show header for selected setup
    show_header
    echo -e "${BLUE}Starting $setup_name setup...${NOCOLOR}\n"
    
    # Execute the setup script
    "$setup_script"
    
    # Check if script executed successfully
    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}$setup_name setup completed successfully!${NOCOLOR}"
    else
        echo -e "\n${RED}$setup_name setup encountered some errors.${NOCOLOR}"
    fi
    
    sleep 2
    main_menu
}

# Main menu to choose setup type
main_menu() {
    show_header
    echo -e "${BLUE}Choose your development environment:${NOCOLOR}\n"
    
    options=(
        "Frontend Development   - React, Vue, Node.js, etc."
        "Backend Development    - Python, Java, Databases, etc."
        "Data Analysis          - Python, R, Jupyter, etc."
        "Custom                 - Choose your own tools"
        "Update Existing Tools  - Update system and packages"
        "Exit"
    )

    # Print options with numbers
    for i in "${!options[@]}"; do
        printf "${GREEN}%3d)${NOCOLOR} %s\n" $((i+1)) "${options[$i]}"
    done

    echo
    read -p "Enter your choice (1-${#options[@]}): " choice

    # Validate input
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#options[@]}" ]; then
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
        5)  update_tools 
            main_menu ;;
        6)  echo -e "\n${GREEN}Thank you for using Setup My Mac Wizard. Goodbye!${NOCOLOR}"
            exit 0 ;;
    esac
}

# Main execution
check_homebrew  # Ensure Homebrew is installed and updated
main_menu       # Display the main menu
