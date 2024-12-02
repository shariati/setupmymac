#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

# Function to check and install Homebrew
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Function to display menu
show_menu() {
    local title=$1
    local -n tools=$2
    local -n selected=$3
    
    echo -e "${BLUE}${title}${NOCOLOR}"
    echo "Select the tools you want to install (toggle with number, ENTER when done):"
    echo -e "${YELLOW}Press ENTER without typing a number to proceed with the installation.${NOCOLOR}"
    echo ""
    
    local i=1
    for tool in "${tools[@]}"; do
        if [[ $tool == \#* ]]; then
            # Print category header
            echo -e "${CYAN}${tool#\# }${NOCOLOR}"
        else
            if [[ " ${selected[@]} " =~ " ${tool} " ]]; then
                echo -e "$i) [${GREEN}X${NOCOLOR}] ${tool}"
            else
                echo -e "$i) [ ] ${tool}"
            fi
            ((i++))
        fi
    done
}

# Function to handle tool selection
handle_selection() {
    local choice=$1
    local -n tools=$2
    local -n selected=$3
    
    if [[ -z "$choice" ]]; then
        return 1
    fi
    
    # Count non-header items
    local valid_items=0
    for tool in "${tools[@]}"; do
        if [[ ! $tool == \#* ]]; then
            ((valid_items++))
        fi
    done
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$valid_items" ]; then
        # Find the actual tool name by skipping headers
        local actual_index=0
        for tool in "${tools[@]}"; do
            if [[ ! $tool == \#* ]]; then
                ((actual_index++))
                if [ "$actual_index" -eq "$choice" ]; then
                    local tool_name="$tool"
                    break
                fi
            fi
        done
        
        if [[ " ${selected[@]} " =~ " ${tool_name} " ]]; then
            # Create a new array without the deselected item
            local new_selected=()
            for t in "${selected[@]}"; do
                if [ "$t" != "$tool_name" ]; then
                    new_selected+=("$t")
                fi
            done
            selected=("${new_selected[@]}")
        else
            selected+=("$tool_name")
        fi
        return 0
    fi
    return 2
}

# Function to confirm installation
confirm_installation() {
    local -n selected=$1
    
    echo -e "\nYou have selected the following tools for installation:"
    for tool in "${selected[@]}"; do
        if [ ! -z "$tool" ]; then
            echo "- $tool"
        fi
    done

    read -p "Do you want to proceed with the installation? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "Installation cancelled."
        return 1
    fi
    return 0
}

# Function to install selected tools
install_tools() {
    echo -e "\n${BLUE}Installing selected tools...${NOCOLOR}\n"

    for tool in "${selected_tools[@]}"; do
        echo -e "Installing ${GREEN}$tool${NOCOLOR}..."
        case $tool in
            # Existing cask installations
            "visual-studio-code"|"firefox"|"google-chrome"|"figma"|"iterm2"|"pgadmin4"|"dbeaver-community"|"rstudio"|"tableau"|"microsoft-excel")
                brew install --cask "$tool" || { echo "Failed to install $tool"; return 1; }
                ;;
            
            # Node version manager (nvm)
            "nvm")
                curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash || { echo "Failed to install $tool"; return 1; }
                # Add NVM to path
                echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
                echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
                source ~/.zshrc
                ;;
            
            # MongoDB with tap
            "mongodb-community")
                brew tap mongodb/brew
                brew install mongodb-community || { echo "Failed to install $tool"; return 1; }
                ;;
            
            # Python packages
            "jupyter")
                pip3 install jupyter || { echo "Failed to install $tool"; return 1; }
                ;;
            
            # Conda installations
            "anaconda")
                brew install --cask anaconda
                echo 'export PATH="/usr/local/anaconda3/bin:$PATH"' >> ~/.zshrc
                source ~/.zshrc
                ;;
            "miniconda")
                brew install --cask miniconda
                echo 'export PATH="/usr/local/miniconda3/bin:$PATH"' >> ~/.zshrc
                source ~/.zshrc
                ;;

            # Node and npm
            "node")
                brew install node || { echo "Failed to install $tool"; return 1; }
                # Install latest npm
                npm install -g npm@latest || { echo "Failed to update npm"; return 1; }
                ;;
            
            # Yarn (requires node)
            "yarn")
                if ! command -v node &> /dev/null; then
                    echo "Node.js is required for Yarn. Installing Node.js first..."
                    brew install node || { echo "Failed to install Node.js"; return 1; }
                fi
                npm install -g yarn || { echo "Failed to install $tool"; return 1; }
                ;;

            # Python and pip
            "python3")
                brew install python3 || { echo "Failed to install $tool"; return 1; }
                ;;
            "pip3")
                curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
                python3 get-pip.py || { echo "Failed to install $tool"; return 1; }
                rm get-pip.py
                ;;

            # R installation
            "r")
                brew install r || { echo "Failed to install $tool"; return 1; }
                ;;

            # Docker and Docker Compose
            "docker")
                brew install --cask docker || { echo "Failed to install $tool"; return 1; }
                ;;
            "docker-compose")
                brew install docker-compose || { echo "Failed to install $tool"; return 1; }
                ;;

            # Frontend tools
            "typescript")
                npm install -g typescript || { echo "Failed to install $tool"; return 1; }
                ;;
            "sass")
                npm install -g sass || { echo "Failed to install $tool"; return 1; }
                ;;
            "webpack")
                npm install -g webpack webpack-cli || { echo "Failed to install $tool"; return 1; }
                ;;
            "eslint")
                npm install -g eslint || { echo "Failed to install $tool"; return 1; }
                ;;
            "prettier")
                npm install -g prettier || { echo "Failed to install $tool"; return 1; }
                ;;

            # Backend tools
            "go")
                brew install go || { echo "Failed to install $tool"; return 1; }
                ;;
            "rust")
                curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || { echo "Failed to install $tool"; return 1; }
                ;;
            "nginx")
                brew install nginx || { echo "Failed to install $tool"; return 1; }
                ;;
            "apache")
                brew install httpd || { echo "Failed to install $tool"; return 1; }
                ;;
            "aws-cli")
                brew install awscli || { echo "Failed to install $tool"; return 1; }
                ;;
            "azure-cli")
                brew install azure-cli || { echo "Failed to install $tool"; return 1; }
                ;;
            "kubectl")
                brew install kubernetes-cli || { echo "Failed to install $tool"; return 1; }
                ;;
            "terraform")
                brew install terraform || { echo "Failed to install $tool"; return 1; }
                ;;

            # Data Analysis tools
            "apache-spark")
                brew install apache-spark || { echo "Failed to install $tool"; return 1; }
                ;;
            "hadoop")
                brew install hadoop || { echo "Failed to install $tool"; return 1; }
                ;;
            "neo4j")
                brew install neo4j || { echo "Failed to install $tool"; return 1; }
                ;;
            "elasticsearch")
                brew install elasticsearch || { echo "Failed to install $tool"; return 1; }
                ;;
            "kibana")
                brew install kibana || { echo "Failed to install $tool"; return 1; }
                ;;

            # Default brew installation for remaining tools
            *)
                brew install "$tool" || { echo "Failed to install $tool"; return 1; }
                ;;
        esac
        echo -e "${GREEN}$tool installed successfully!${NOCOLOR}"
    done
    return 0
}

# Function to perform post-installation setup
post_install_setup() {
    local -n selected=$1
    
    for tool in "${selected[@]}"; do
        case $tool in
            "python3")
                echo "Installing essential Python data science packages..."
                pip3 install numpy pandas scipy matplotlib seaborn scikit-learn tensorflow pytorch || { echo "Failed to install Python packages"; return 1; }
                ;;
            "r")
                echo "Installing essential R packages..."
                Rscript -e 'install.packages(c("tidyverse", "ggplot2", "dplyr", "caret", "shiny"), repos="https://cran.rstudio.com/")' || { echo "Failed to install R packages"; return 1; }
                ;;
            "postgresql")
                echo "Starting PostgreSQL service..."
                brew services start postgresql
                ;;
            "mongodb-community")
                echo "Starting MongoDB service..."
                brew services start mongodb-community
                ;;
            "mysql")
                echo "Starting MySQL service..."
                brew services start mysql
                ;;
            "redis")
                echo "Starting Redis service..."
                brew services start redis
                ;;
            "docker")
                echo "Ensuring Docker is running..."
                open -a Docker
                ;;
            "nginx")
                echo "Starting Nginx service..."
                brew services start nginx
                ;;
            "apache")
                echo "Starting Apache service..."
                brew services start httpd
                ;;
            "elasticsearch")
                echo "Starting Elasticsearch service..."
                brew services start elasticsearch
                ;;
            "kibana")
                echo "Starting Kibana service..."
                brew services start kibana
                ;;
            "neo4j")
                echo "Starting Neo4j service..."
                brew services start neo4j
                ;;
        esac
    done
    return 0
}

# Function to show completion message
show_completion_message() {
    local -n selected=$1
    
    echo -e "\n${GREEN}All selected tools have been installed successfully!${NOCOLOR}"
    echo -e "${YELLOW}Note: Some services have been started automatically. You can manage them using 'brew services'${NOCOLOR}"
    
    # Show additional messages based on installed tools
    if [[ " ${selected[@]} " =~ " python3 " ]]; then
        echo -e "${YELLOW}Additional Python packages installed: numpy, pandas, scipy, matplotlib, seaborn, scikit-learn, tensorflow, pytorch${NOCOLOR}"
    fi
    if [[ " ${selected[@]} " =~ " r " ]]; then
        echo -e "${YELLOW}Additional R packages installed: tidyverse, ggplot2, dplyr, caret, shiny${NOCOLOR}"
    fi
} 