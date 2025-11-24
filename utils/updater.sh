#!/bin/bash

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
