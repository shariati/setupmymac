# Setup My Mac for Development
A comprehensive shell script collection to setup your MacOS for various development environments.

## ⚠️ Important Disclaimer
By using this script, you acknowledge and agree to the following:

1. You have read and understood the source code of the scripts you're about to execute
2. You are aware of all software and packages that will be installed on your system
3. The maintainer(s) of this script assume NO RESPONSIBILITY for any damages, data loss, or system issues that may occur
4. It is YOUR responsibility to review the code and understand its impact on your system
5. This script is provided "AS IS", without warranty of any kind

**Always read shell scripts before executing them on your system. This is not just a recommendation, it's a crucial security practice.**

## Requirements
* macOS Sierra (10.12) or later
* Basic understanding of shell scripts and development tools
* Terminal access

## Features
* Modular setup scripts for different development environments
* Interactive tool selection
* Automated installation and configuration
* Support for multiple development environments:
  - Frontend Development (Node.js, React, etc.)
  - Backend Development (Python, Databases, etc.)
  - Data Analysis (Python, R, Jupyter, etc.)
  - Custom setup with all available tools

## Installation

```sh
curl --remote-name https://raw.githubusercontent.com/yourusername/setupmymac/master/setup-my-mac.sh
chmod +x setup-my-mac.sh
./setup-my-mac.sh
```

## What Gets Installed?

### Frontend Development Tools
* Node.js and npm
* Yarn
* Visual Studio Code
* Web browsers (Chrome, Firefox)
* Postman
* Figma
* ImageMagick
* Git

### Backend Development Tools
* Python3 and pip
* PostgreSQL
* MySQL
* MongoDB
* Redis
* Docker
* iTerm2
* Database management tools
* Git

### Data Analysis Tools
* Python3 and pip
* R and RStudio
* Jupyter
* Anaconda/Miniconda
* Database tools
* Tableau
* Essential data science packages

### Common Tools
* Git
* Visual Studio Code
* Essential development utilities

## Structure
```
.
├── setup-my-mac.sh          # Main script
├── scripts/
│   ├── frontend-setup.sh    # Frontend tools
│   ├── backend-setup.sh     # Backend tools
│   ├── data-analysis.sh     # Data analysis tools
│   └── custom-setup.sh      # Custom environment
└── utils/
    └── helper.sh            # Common functions
```

## Contributing
1. Fork the repository
2. Create your feature branch
3. Make your changes
4. Submit a pull request

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
* [Homebrew](https://brew.sh/) - The missing package manager for macOS
* All the amazing open-source tools included in this script

## Support
If you encounter any issues, please check:
1. Your macOS version compatibility
2. Homebrew installation status
3. Internet connectivity
4. System permissions

Then create an issue in the repository with details about your problem.
