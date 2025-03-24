# My Zsh Configuration

A well-organized and optimized Zsh configuration setup with support for development workflows, particularly focused on Node.js, Git, and company-specific tooling.

## Features

- 🚀 Optimized shell startup time with profiling support
- 📁 Organized configuration structure
- 🔧 Smart script loading system (on-demand and auto-loaded)
- 🛠️ Development workflow tools
  - Quick PR creation with JIRA integration
  - Dependency update automation
  - Git workflow optimization
- 🏢 Company-specific configurations isolated
- ⚡ Efficient plugin management

## Directory Structure

```
~/.zsh/
├── scripts/           # Frequently used scripts
├── scripts-ondemand/  # Scripts loaded on-demand
├── aliases.zsh        # General aliases
├── company.zsh        # Company-specific settings
├── env.zsh           # Environment variables
├── omz.zsh           # Oh-My-Zsh configuration
└── sdks.zsh          # SDK configurations
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/maddestructor/zshconfigs.git ~/.zsh
```

2. Modify your `~/.zshrc`:

```bash
# Start profiling (optional)
zmodload zsh/zprof

# Load environment variables
source ~/.zsh/env.zsh

# Load other configuration files
for config_file in ~/.zsh/*.zsh; do
  source $config_file
done

# Load frequently used scripts
for script_file in ~/.zsh/scripts/*.sh; do
  source $script_file
done

# End profiling (optional)
zprof
```

3. Install required tools:

- [Oh-My-Zsh](https://ohmyz.sh/)
- [GitHub CLI](https://cli.github.com/)
- [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/)

## Available Commands

### Quick PR Creation

```bash
quickPR <JIRA ticket> <title>
# Examples:
quickPR PFM-123 "Add new feature"      # Creates PR with existing ticket
quickPR 123 "Add new feature"          # Creates PR with JIRA_PROJECT-123
quickPR 000 "Fix something"            # Creates new JIRA ticket and PR
```

### Dependency Updates

```bash
bump-interactive
# Interactively update dependencies and create a PR
```

### Company Scripts

```bash
load-company-scripts
# Load additional company-specific scripts when needed
```

## Customization

1. Environment Variables: Edit `env.zsh` to modify paths and environment variables
2. Aliases: Add custom aliases to `aliases.zsh`
3. Company Settings: Modify `company.zsh` for company-specific configurations
4. Scripts: Add new scripts to either `scripts/` or `scripts-ondemand/`

## Performance

To check shell startup performance:

1. Uncomment the `zmodload zsh/zprof` and `zprof` lines in `.zshrc`
2. Start a new shell
3. Review the profiling output

## Author

- [@maddestructor](https://www.github.com/maddestructor)

## Contributing

Feel free to submit issues and enhancement requests!
