# complet & color

_cache_hosts=()

fpath=($fpath ~/.zsh/functions)

autoload -U compinit
compinit -u

autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^Z' predict-on
bindkey '^Z' predict-off
zstyle ':predict' verbose true

if [ `uname` = 'Darwin' ]; then
  eval `gdircolors ~/.zsh/.dircolors`
else
  eval `dircolors ~/.zsh/.dircolors`
fi

zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:descriptions' format 'completing %B%d%b'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#zstyle ':completion:*:cd:*' tag-order local-directories path-directories

zstyle ':completion:*:cd:*' tag-order local-directories
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:(rm|cp|mv|vi|git):*' ignore-line true

function  _cap () {
  `cap -T | grep '^cap ' | sed 's/^cap //' | sed 's/ .*//' | sed 's/^/compadd /'`
}
compdef _cap cap

setopt MENU_COMPLETE
setopt COMPLETE_IN_WORD

# for google
if [ -e ~/google-cloud-sdk/ ]; then
  source ~/google-cloud-sdk/completion.zsh.inc
fi
