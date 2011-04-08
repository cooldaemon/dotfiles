bindkey -v
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

#bindkey '^R' history-incremental-search-backward
zsh-history() {
  zaw zaw-src-history
}
zle -N zsh-history
bindkey '^R' zsh-history

function cdup() {
  echo
  cd ..
  zle push-line-or-edit
  zle accept-line
}
zle -N cdup
bindkey '^U' cdup

