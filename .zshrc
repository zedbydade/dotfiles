export ZSH="$HOME/.oh-my-zsh"
export EDITOR='lvim'
ZSH_THEME=robbyrussell

plugins=(
	git
	zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# Extend PATH.
typeset -U path
path=(
  /usr/local/{bin,sbin}
  $HOME/.cargo/bin
  $HOME/.local/bin
  $path
)
alias ls="exa --icons"
alias cat="bat --style=auto"
alias up='docker compose up'
alias down='docker compose down'
alias build='docker compose build'
alias logs='docker compose logs --follow'
alias dps='docker ps'
alias nvim='lvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
source /opt/asdf-vm/asdf.sh

# Alt+left/right to move by word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
