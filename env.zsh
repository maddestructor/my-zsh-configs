export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Fast Node Manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Android SDK Configuration
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/{tools/bin,platform-tools,cmdline-tools/latest/bin}

# Development Tools
export PATH=$PATH:/opt/homebrew/bin/tsc:/opt/homebrew/bin/yarn:$HOME/.dotnet/tools

# Custom Scripts
export PATH=$PATH:$HOME/.scripts
source $HOME/.scripts/*

# Company-specific Configuration
export MX_SLUG=mb1mac
