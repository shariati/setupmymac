# Setup My Mac for Development
A comprehensive shell script collection to setup your macOS for various development environments.

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
* Interactive tool selection with toggle functionality
* Automated installation and configuration
* **Dry Run Mode**: Preview commands without executing them (`--dry-run`)
* **Logging**: detailed installation logs saved to `setup_log.txt`
* Support for multiple development environments:
  - Frontend Development (Node.js, React, etc.)
  - Backend Development (Python, Databases, etc.)
  - Data Analysis (Python, R, Jupyter, etc.)
  - Custom setup with all available tools
  - Update Existing Tools (Homebrew, npm, pip, etc.)

## Installation

```sh
curl --remote-name https://raw.githubusercontent.com/yourusername/setupmymac/master/setup-my-mac.sh
chmod +x setup-my-mac.sh
./setup-my-mac.sh
```

### Dry Run (Safe Mode)
To see what commands will be executed without actually installing anything:
```sh
./setup-my-mac.sh --dry-run
```

## What Gets Installed?

### Frontend Development Tools
* Node.js and npm
* Yarn
* NVM (Node Version Manager)
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
* Docker and Docker Compose
* iTerm2
* Database management tools (pgAdmin4, DBeaver)
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


### Adding New Software and Tools

If you want to contribute by adding new software or tools to the setup scripts, follow these steps:

1. **Fork the Repository**: Start by forking the repository to your GitHub account.

2. **Clone the Repository**: Clone your forked repository to your local machine.
   ```sh
   git clone https://github.com/yourusername/setupmymac.git
   cd setupmymac
   ```

3. **Create a New Branch**: Create a new branch for your changes.
   ```sh
   git checkout -b feat/add-new-tool
   ```

4. **Modify the Setup Script**:
   - Open the appropriate setup script in the `scripts/` directory (e.g., `frontend-setup.sh`, `backend-setup.sh`, `data-analysis-setup.sh`, or `custom-setup.sh`).
   - Add the new tool to the `tool_names` array.
   - Ensure the tool is also added to the `selected_tools` array if you want it to be selected by default.

5. **Update the Helper Script**:
   - Open `utils/helper.sh`.
   - Add a new case in the `install_tools()` function to handle the installation of the new tool. Use `brew install` or other appropriate commands.
   - If necessary, add any post-installation steps in the `post_install_setup()` function.

6. **Test Your Changes**: Run the modified script to ensure the new tool installs correctly and without errors.

7. **Commit Your Changes**: Follow the Conventional Commits specification for your commit message.
   ```sh
   # For adding a new tool
   git add .
   git commit -m "feat: add [Tool Name] to setup scripts"

   # For fixing a tool installation
   git commit -m "fix: correct [Tool Name] installation process"

   # For updating documentation
   git commit -m "docs: update [Tool Name] installation instructions"

   # For improving existing functionality
   git commit -m "refactor: optimize [Tool Name] installation"
   ```

   Common commit types:
   - `feat`: A new feature or tool
   - `fix`: A bug fix
   - `docs`: Documentation changes
   - `style`: Code style changes (formatting, etc.)
   - `refactor`: Code changes that neither fix bugs nor add features
   - `test`: Adding or modifying tests
   - `chore`: Changes to the build process or auxiliary tools

8. **Push Your Changes**: Push your changes to your forked repository.
   ```sh
   git push origin feat/add-new-tool
   ```

9. **Submit a Pull Request**: Go to the original repository on GitHub and submit a pull request from your branch.

10. **Review and Feedback**: The maintainers will review your pull request. Be prepared to make any requested changes.

By following these steps and commit message conventions, you can contribute new tools to the setup scripts, helping to expand the functionality and usefulness of the project for all users.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Please also read the [Legal Note & Disclaimer](LEGAL_NOTE.md) for important information regarding warranties, liability, and third-party software licenses.

## Acknowledgments
* [Homebrew](https://brew.sh/) - The missing package manager for macOS
* All the amazing open-source tools included in this script

## Credits
This script was originally developed by [Amin](https://github.com/shariati) and is maintained by the open source community.

## Open Source
This is an open source project! We believe in the power of community collaboration.
- **Source Code**: The code is available on GitHub.
- **Contributions**: We welcome pull requests for new features, bug fixes, and improvements.
- **License**: MIT License.

## Critical Disclaimer
**By running these scripts, you confirm that you have read and understood the code. You acknowledge that you are fully aware of what the script does and take full responsibility for any changes made to your system. NEVER execute a script without reading the commands it executes. The expectation is that you know and fully understand the code before execution.**

Feel free to fork, modify, and share!

## Support
If you encounter any issues, please check:
1. Your macOS version compatibility
2. Homebrew installation status
3. Internet connectivity
4. System permissions

Then create an issue in the repository with details about your problem.

## Version
**2.0.2**

Latest Updates:
- Added new frontend development tools:
  * TypeScript, Sass, Webpack
  * ESLint, Prettier
  * React/Vue.js DevTools
  * Lighthouse
- Expanded backend tools:
  * Go, Rust
  * Cloud tools (AWS/Azure CLI)
  * Infrastructure tools (Terraform, kubectl)
  * Web servers (Nginx, Apache)
  * GraphQL
- Enhanced data analysis suite:
  * Big data tools (Apache Spark, Hadoop)
  * Additional databases (Neo4j, Elasticsearch)
  * Visualization tools (Kibana, Power BI)
  * Machine learning frameworks (TensorFlow, PyTorch)
- Improved tool categorization and documentation
