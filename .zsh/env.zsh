# Loading every bash script functions from my home scripts folder
export PATH=$PATH:/Users/mathieu/.scripts
source ~/.scripts/*

# MX Environment variables
export MX_SLUG=mb1%

# NVM Environment variables
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
