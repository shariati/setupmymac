# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability within this project, please report it by creating a new issue in the GitHub repository with the label `security` or by contacting the maintainers directly. We take all security vulnerabilities seriously and will respond as soon as possible.

## Security Features

To ensure the safety of your system, this project implements several security best practices:

*   **Input Validation**: User inputs in the interactive menu are strictly validated to prevent injection attacks or unexpected behavior.
*   **Safe Variable Handling**: Variables in the scripts are quoted to prevent word splitting and globbing issues.
*   **Strict Mode**: The scripts run with `set -u` to treat unset variables as an error, preventing accidental misconfiguration.
*   **Dry Run Mode**: You can run the script with the `--dry-run` flag to inspect exactly what commands will be executed without making any changes to your system.
    ```bash
    ./setup-my-mac.sh --dry-run
    ```

## Known Risks & Best Practices

### Remote Script Execution (`curl | bash`)
This project uses the common pattern of piping `curl` output to `bash` for installing certain tools (Homebrew, NVM, Rust). While convenient, this method carries inherent risks if the remote server is compromised.

**Recommendation**:
*   We strongly advise reviewing the source code of the installers for Homebrew, NVM, and Rust if you have high-security requirements.
*   You can manually install these tools and then run this script to install the rest of your environment.

### Sudo Privileges
Some installations (like Homebrew or system packages) may require `sudo` access. The script itself does not store or handle your password; it relies on the underlying tools (like `brew`) to request permissions when necessary.

## Critical Disclaimer

**By running these scripts, you confirm that you have read and understood the code.** You acknowledge that you are fully aware of what the script does and take full responsibility for any changes made to your system. NEVER execute a script without reading the commands it executes.
