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

############
# Functions
############

# Parse current git branch, if any
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/[()]//g' -e 's/.*/ (&)/'
}

#########
# Prompt
#########
setopt PROMPT_SUBST
PROMPT='%F{cyan}@%f%F{cyan}%m%f%F{cyan}:%f%F{yellow}%~%f%F{white}$(parse_git_branch)%f $ '

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

# Load Anaconda, base env disabled by default, run `conda activate` to enable
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

