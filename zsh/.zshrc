

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



export GOPROXY=https://goproxy.io,direct

PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
PATH="$PATH:/Users/Wangxin/go/bin"
export PATH

# yazi
function yy() {
local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


alias la=lazygit
alias ld=lazydocker
# alias S=neofetch
alias S=fastfetch
alias jo=yy
alias Yazi=yy
alias ls="eza --icons"
alias ll="eza -l --icons"

eval "$(zoxide init zsh)"
alias cd="z"

eval "$(starship init zsh)"
