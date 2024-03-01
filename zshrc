# Load environment variables
source ~/.zsh/env.zsh

# Load other configuration files
for config_file in ~/.zsh/*.zsh; do
  source $config_file
done

# Load script files
for script_file in ~/.zsh/scripts/*.sh; do
  source $script_file
done

