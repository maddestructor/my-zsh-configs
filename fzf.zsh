export FZF_BASE=~/.fzf/bin/fzf
export FZF_DEFAULT_COMMAND='rg --color never --files'
export FZF_CTRL_T_COMMAND="rg --files . 2>/dev/null"
export FZF_ALT_C_COMMAND="fd -t d 2>/dev/null"
export FZF_DEFAULT_OPTS='--height 30% --layout=reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh