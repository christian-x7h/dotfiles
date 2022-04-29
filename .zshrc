################
# AutoCompletion
################

# Enable zsh backward compatibility with bash auto-completions
#  begin to source completion files, starting with brew-installed completions 
autoload bashcompinit && bashcompinit
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# Enable zsh auto-completions, 
#  include brew-installed completions
#   disable compinit security check with `-C`
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit -C
fi

#########
# Prompt
#########
PROMPT="%F{cyan}@%f%F{cyan}%m%f%F{cyan}:%f%F{yellow}%~%f $ "

#########
# Aliases
#########

# Enable git managed dotfiles (see .dotalias folder for more info)
alias dotfiles='/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Improve 'ls' behavior and colors to match prompt
export LSCOLORS='dxfxcxdxbxegedabagacad'
alias ls='ls -GFh'

##############
# Dev Tooling
#############

# Enable Jenv for JVM management
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Enable NVM for Node management
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
