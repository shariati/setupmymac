#!/bin/bash


# Available Colors to use in Console

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[1;31m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHT_BLUE='\033[1;34m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_CYAN='\033[1;36m'
WHITE='\033[1;37m'
NOCOLOR='\033[0m'

# Check if Tool, Package is available
check_cask() {
  if brew ls --versions brew-cask-completion > /dev/null; then
    # cask is installed then try to upgrade
    brew upgrade brew-cask-completion
  else
    # cask is not installed try to install
    brew tap caskroom/cask
    brew install brew-cask-completion
  fi
}
check_java() {
  if java -version > /dev/null; then
    # Java is installed
    brew upgrade brew-cask-completion
  else
    # Java is not installed try to install
      brew cask install java
  fi
}

check_homebrew() {
  echo -e "Checking for ${BROWN}homebrew${NOCOLOR}"
  if brew -v > /dev/null; then
    # homebrew is installed
    homebrew_update

  else
    # homebrew is not installed
    homebrew_install
  fi
  homebrew_runtimes
  homebrew_libraries
  check_node
}

homebrew_install() {
    echo -e "Installing ${BROWN}homebrew${NOCOLOR}"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

homebrew_update() {
  echo -e "${BLUE}Updating${NOCOLOR} ${BROWN}homebrew${NOCOLOR}..."
  brew update
  check_cask
  brew upgrade
  brew cleanup
  brew cask cleanup  
}

check_node() {
  echo -e "Checking for ${LIGHT_GREEN}NodeJS${NOCOLOR}"
  if ! node -v > /dev/null; then
    # Node is installed
    brew upgrade node
  else
    # Node is not installed
    echo -e "Installing ${LIGHT_GREEN}homebrew${NOCOLOR}..."

    brew install node
  fi
  node_modules
}

node_modules() {
  npm i -g npm
  npm install -g begoo
  begoo "Installing Live-Server, Cordova, Yeoman "
  npm install -g live-server
  npm install -g cordova
  npm install -g yo

}

homebrew_libraries() {
  brew install imagemagick
}
# runtimes and package managers
homebrew_runtimes() {
  brew update
  check_java
  brew install node
  brew install yarn
  brew install watchman
  brew install mongodb
  brew install rbenv
  rbenv init
}

check_homebrew
