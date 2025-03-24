# Company-specific Environment Variables
export MX_SLUG=mb1mac

# Company-specific Aliases
alias main="cd ~/Repositories/maintainx"
alias edb="yarn & yarn ensureDb"

# Company-specific Functions
function load-company-scripts() {
    # Load on-demand company scripts when needed
    for script_file in ~/.zsh/scripts-ondemand/*.sh; do
        source $script_file
    done
}

# AWS Helper
alias sso="aws sso login" 