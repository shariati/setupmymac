#!/bin/bash

echo "Select the setup you want to run:"
options=("Frontend Development" "Backend Development" "Fullstack Development" "Data Analysis" "Custom")
select opt in "${options[@]}"; do
    case $opt in
        "Frontend Development")
            ./scripts/frontend-setup.sh
            break
            ;;
        "Backend Development")
            ./scripts/backend-setup.sh
            break
            ;;
        "Fullstack Development")
            ./scripts/fullstack-setup.sh
            break
            ;;
        "Data Analysis")
