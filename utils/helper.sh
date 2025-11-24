#!/bin/bash

# Colors for console output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

# Logging function
log_message() {
    local message="$1"
    echo -e "$message"
    # Strip color codes for log file
    echo -e "$message" | sed 's/\x1b\[[0-9;]*m//g' >> "${LOG_FILE:-/dev/null}"
}

# Command execution wrapper for Dry Run
run_install_cmd() {
    local cmd="$*"
    if [ "${DRY_RUN:-false}" = true ]; then
        log_message "${YELLOW}[DRY RUN] Would execute: $cmd${NOCOLOR}"
        return 0
    else
        log_message "Executing: $cmd"
        eval "$cmd"
        return $?
    fi
}

# Function to check and install Homebrew
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew"; exit 1; }
    fi
}

# Function to display menu
show_menu() {
    local title="$1"
    shift
    local tools=("$@")
    
    echo -e "${BLUE}${title}${NOCOLOR}"
    echo "Select the tools you want to install (toggle with number, ENTER when done):"
    echo -e "${YELLOW}Press ENTER without typing a number to proceed with the installation.${NOCOLOR}"
    echo ""
    
    local i=1
    for tool in "${tools[@]}"; do
        if [[ "$tool" == \#* ]]; then
            # Print category header
            echo -e "${CYAN}${tool#\# }${NOCOLOR}"
        else
            if [[ " ${selected_tools[@]} " =~ " ${tool} " ]]; then
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
    local choice="$1"
    shift
    local tools=("$@")
    
    if [[ -z "$choice" ]]; then
        return 1
    fi
    
    # Count non-header items
    local valid_items=0
    for tool in "${tools[@]}"; do
        if [[ ! "$tool" == \#* ]]; then
            ((valid_items++))
        fi
    done
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "$valid_items" ]; then
        # Find the actual tool name by skipping headers
        local actual_index=0
        for tool in "${tools[@]}"; do
            if [[ ! "$tool" == \#* ]]; then
                ((actual_index++))
                if [ "$actual_index" -eq "$choice" ]; then
                    local tool_name="$tool"
                    break
                fi
            fi
        done
        
        if [[ " ${selected_tools[@]} " =~ " ${tool_name} " ]]; then
            # Create a new array without the deselected item
            local new_selected=()
            for t in "${selected_tools[@]}"; do
                if [ "$t" != "$tool_name" ]; then
                    new_selected+=("$t")
                fi
            done
            selected_tools=("${new_selected[@]}")
        else
            selected_tools+=("$tool_name")
        fi
        return 0
    fi
    return 2
}

# Function to confirm installation
confirm_installation() {
    local tools=("$@")
    
    echo -e "\nYou have selected the following tools for installation:"
    for tool in "${tools[@]}"; do
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

# Function to install a single tool
install_single_tool() {
    local tool=$1
    log_message "Installing ${GREEN}$tool${NOCOLOR}..."
    
    case $tool in
        # Existing cask installations
        "visual-studio-code"|"firefox"|"google-chrome"|"figma"|"iterm2"|"pgadmin4"|"dbeaver-community"|"rstudio"|"tableau"|"microsoft-excel")
            run_install_cmd "brew install --cask $tool" || return 1
            ;;
        # Docker and Docker Compose
        "docker")
            run_install_cmd "brew install --cask docker" || return 1
            ;;
        "docker-compose")
            run_install_cmd "brew install docker-compose" || return 1
            ;;
        # Frontend tools
        "node")
            run_install_cmd "brew install node" || return 1
            # Install latest npm
            run_install_cmd "npm install -g npm@latest" || return 1
            ;;
        # Node version manager (nvm)
        "nvm")
            # SECURITY NOTE: Piping curl to bash is risky. Ensure the URL is trusted.
            run_install_cmd "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash" || { log_message "Failed to install $tool"; return 1; }
            # Add NVM to path
            if [ "${DRY_RUN:-false}" = false ]; then
                echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
                echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc
                source ~/.zshrc
            else
                 log_message "${YELLOW}[DRY RUN] Would add NVM to .zshrc${NOCOLOR}"
            fi
            ;;             
        "yarn")
            if ! command -v node &> /dev/null && [ "${DRY_RUN:-false}" = false ]; then
                log_message "Node.js is required for Yarn. Installing Node.js first..."
                run_install_cmd "brew install node" || return 1
            fi
            run_install_cmd "npm install -g yarn" || return 1
            ;;
        "typescript")
            run_install_cmd "npm install -g typescript" || return 1
            ;;
        "sass")
            run_install_cmd "npm install -g sass" || return 1
            ;;
        "webpack")
            run_install_cmd "npm install -g webpack webpack-cli" || return 1
            ;;
        "eslint")
            run_install_cmd "npm install -g eslint" || return 1
            ;;
        "prettier")
            run_install_cmd "npm install -g prettier" || return 1
            ;;
        "react-devtools")
            run_install_cmd "npm install -g react-devtools" || return 1
            ;;
        "vue-devtools")
            run_install_cmd "npm install -g @vue/devtools" || return 1
            ;;
        "lighthouse")
            run_install_cmd "npm install -g lighthouse" || return 1
            ;;
        # Backend tools
        "mongodb-community")
            run_install_cmd "brew tap mongodb/brew"
            run_install_cmd "brew install mongodb-community" || return 1
            ;;
        "go")
            run_install_cmd "brew install go" || return 1
            ;;
        "rust")
            # SECURITY NOTE: Piping curl to sh is risky. Ensure the URL is trusted.
            run_install_cmd "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" || { log_message "Failed to install $tool"; return 1; }
            ;;
        "nginx")
            run_install_cmd "brew install nginx" || return 1
            ;;
        "apache")
            run_install_cmd "brew install httpd" || return 1
            ;;
        "aws-cli")
            run_install_cmd "brew install awscli" || return 1
            ;;
        "azure-cli")
            run_install_cmd "brew install azure-cli" || return 1
            ;;
        "kubectl")
            run_install_cmd "brew install kubernetes-cli" || return 1
            ;;
        "terraform")
            run_install_cmd "brew install terraform" || return 1
            ;;
        "graphql")
            run_install_cmd "npm install -g graphql" || return 1
            ;;
        # Data Analysis tools
        "python3")
            run_install_cmd "brew install python3" || return 1
            ;;
        "pip3")
            run_install_cmd "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py"
            run_install_cmd "python3 get-pip.py" || return 1
            run_install_cmd "rm get-pip.py"
            ;;
        "jupyter")
            run_install_cmd "pip3 install jupyter" || return 1
            ;;
        "anaconda")
            run_install_cmd "brew install --cask anaconda"
            if [ "${DRY_RUN:-false}" = false ]; then
                echo 'export PATH="/usr/local/anaconda3/bin:$PATH"' >> ~/.zshrc
                source ~/.zshrc
            else
                log_message "${YELLOW}[DRY RUN] Would add Anaconda to .zshrc${NOCOLOR}"
            fi
            ;;
        "miniconda")
            run_install_cmd "brew install --cask miniconda"
            if [ "${DRY_RUN:-false}" = false ]; then
                echo 'export PATH="/usr/local/miniconda3/bin:$PATH"' >> ~/.zshrc
                source ~/.zshrc
            else
                log_message "${YELLOW}[DRY RUN] Would add Miniconda to .zshrc${NOCOLOR}"
            fi
            ;;        
        "apache-spark")
            run_install_cmd "brew install apache-spark" || return 1
            ;;
        "hadoop")
            run_install_cmd "brew install hadoop" || return 1
            ;;
        "neo4j")
            run_install_cmd "brew install neo4j" || return 1
            ;;
        "elasticsearch")
            run_install_cmd "brew install elasticsearch" || return 1
            ;;
        "kibana")
            run_install_cmd "brew install kibana" || return 1
            ;;
        "power-bi")
            run_install_cmd "brew install --cask power-bi" || return 1
            ;;
        "tensorflow")
            run_install_cmd "pip3 install tensorflow" || return 1
            ;;
        "pytorch")
            run_install_cmd "pip3 install torch torchvision" || return 1
            ;;
        "r")
            run_install_cmd "brew install r" || return 1
            ;;            
        # Default brew installation for remaining tools
        *)
            run_install_cmd "brew install $tool" || return 1
            ;;
    esac
    
    log_message "${GREEN}$tool installed successfully!${NOCOLOR}"
    return 0
}

# Function to install selected tools
install_tools() {
    log_message "\n${BLUE}Installing selected tools...${NOCOLOR}\n"

    for tool in "${selected_tools[@]}"; do
        install_single_tool "$tool"
        if [ $? -ne 0 ]; then
            log_message "${RED}Failed to install $tool${NOCOLOR}"
        fi
    done
    return 0
}

# Function to perform post-installation setup
post_install_setup() {
    local tools=("$@")
    
    for tool in "${tools[@]}"; do
        case $tool in
            "python3")
                log_message "Installing essential Python data science packages..."
                run_install_cmd "pip3 install numpy pandas scipy matplotlib seaborn scikit-learn tensorflow pytorch" || { log_message "Failed to install Python packages"; return 1; }
                ;;
            "r")
                log_message "Installing essential R packages..."
                run_install_cmd "Rscript -e 'install.packages(c(\"tidyverse\", \"ggplot2\", \"dplyr\", \"caret\", \"shiny\"), repos=\"https://cran.rstudio.com/\")'" || { log_message "Failed to install R packages"; return 1; }
                ;;
            "postgresql")
                log_message "Starting PostgreSQL service..."
                run_install_cmd "brew services start postgresql"
                ;;
            "mongodb-community")
                log_message "Starting MongoDB service..."
                run_install_cmd "brew services start mongodb-community"
                ;;
            "mysql")
                log_message "Starting MySQL service..."
                run_install_cmd "brew services start mysql"
                ;;
            "redis")
                log_message "Starting Redis service..."
                run_install_cmd "brew services start redis"
                ;;
            "docker")
                log_message "Ensuring Docker is running..."
                run_install_cmd "open -a Docker"
                ;;
            "nginx")
                log_message "Starting Nginx service..."
                run_install_cmd "brew services start nginx"
                ;;
            "apache")
                log_message "Starting Apache service..."
                run_install_cmd "brew services start httpd"
                ;;
            "elasticsearch")
                log_message "Starting Elasticsearch service..."
                run_install_cmd "brew services start elasticsearch"
                ;;
            "kibana")
                log_message "Starting Kibana service..."
                run_install_cmd "brew services start kibana"
                ;;
            "neo4j")
                log_message "Starting Neo4j service..."
                run_install_cmd "brew services start neo4j"
                ;;
        esac
    done
    return 0
}

# Function to show completion message
show_completion_message() {
    local tools=("$@")
    
    log_message "\n${GREEN}All selected tools have been installed successfully!${NOCOLOR}"
    log_message "${YELLOW}Note: Some services have been started automatically. You can manage them using 'brew services'${NOCOLOR}"
    
    # Show additional messages based on installed tools
    if [[ " ${tools[@]} " =~ " python3 " ]]; then
        log_message "${YELLOW}Additional Python packages installed: numpy, pandas, scipy, matplotlib, seaborn, scikit-learn, tensorflow, pytorch${NOCOLOR}"
    fi
    if [[ " ${tools[@]} " =~ " r " ]]; then
        log_message "${YELLOW}Additional R packages installed: tidyverse, ggplot2, dplyr, caret, shiny${NOCOLOR}"
    fi
}

# Function to update existing tools
update_tools() {
    echo -e "\n${BLUE}Updating development tools...${NOCOLOR}\n"

    # 1. Update Homebrew and packages
    if command -v brew &> /dev/null; then
        echo -e "${CYAN}Updating Homebrew...${NOCOLOR}"
        brew update
        echo -e "${CYAN}Upgrading Homebrew packages...${NOCOLOR}"
        brew upgrade
        echo -e "${CYAN}Upgrading Homebrew casks...${NOCOLOR}"
        brew upgrade --cask
        echo -e "${GREEN}Homebrew update complete!${NOCOLOR}\n"
    fi

    # 2. Update Node.js global packages
    if command -v npm &> /dev/null; then
        echo -e "${CYAN}Updating global npm packages...${NOCOLOR}"
        npm update -g
        echo -e "${GREEN}npm packages updated!${NOCOLOR}\n"
    fi

    # 3. Update Python packages
    if command -v pip3 &> /dev/null; then
        echo -e "${CYAN}Upgrading pip...${NOCOLOR}"
        pip3 install --upgrade pip
        echo -e "${CYAN}Upgrading installed pip packages...${NOCOLOR}"
        # Get list of outdated packages and upgrade them
        pip3 list --outdated --format=json | python3 -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))" | xargs -n1 pip3 install --upgrade 2>/dev/null
        echo -e "${GREEN}Python packages updated!${NOCOLOR}\n"
    fi

    # 4. Update Rust
    if command -v rustup &> /dev/null; then
        echo -e "${CYAN}Updating Rust...${NOCOLOR}"
        rustup update
        echo -e "${GREEN}Rust updated!${NOCOLOR}\n"
    fi

    # 5. Update Oh My Zsh (if installed)
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Updating Oh My Zsh...${NOCOLOR}"
        env ZSH="$ZSH" sh "$ZSH/tools/upgrade.sh"
        echo -e "${GREEN}Oh My Zsh updated!${NOCOLOR}\n"
    fi

    echo -e "${GREEN}All updates completed successfully!${NOCOLOR}"
    read -p "Press Enter to return to main menu..."
} 