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

check_homebrew() {
  echo -e "Checking for ${BROWN}homebrew${NOCOLOR}"
  if brew -v > /dev/null; then
    # homebrew is installed
    check_homebrew_update

  else
    # homebrew is not installed
    echo Couldn\'t find homebrew. Downloading the package...

  fi
}

check_homebrew_update() {
  echo -e "${BLUE}Updating${NOCOLOR} ${BROWN}homebrew${NOCOLOR}..."
  brew update
  brew upgrade  
}

check_ruby() {
  echo -e "Checking for ${RED}ruby${NOCOLOR}"
  if ruby -v > /dev/null; then
    # ruby is installed
    

  else
    # ruby is not installed
    echo Couldn\'t find homebrew. Downloading the package...

  fi
}
check_ruby_update() {

}

check_oh_my_zsh() {
  echo -e "checking for Oh My ZSH"

}

check_ruby
#check_homebrew
