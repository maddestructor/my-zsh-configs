export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/jre

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Adding Android SDK to PATH
export PATH=$PATH:/Users/mathieu/Library/Android/sdk/tools/bin
export PATH=$PATH:/Users/mathieu/Library/Android/sdk/platform-tools

# Adding Dev tools to PATH
export PATH=$PATH:/opt/homebrew/bin/tsc
export PATH=$PATH:/opt/homebrew/bin/yarn
export PATH=$PATH:/Users/mathieu/.dotnet/tools

# Loading every bash script functions from my home scripts folder
export PATH=$PATH:/Users/mathieu/.scripts
source ~/.scripts/*

# MX Environment variables
export MX_SLUG=mb1
