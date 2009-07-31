# complet & color

_cache_hosts=(svn.zerolocal.jp pubmail.zerolocal.jp pm01.zerolocal.jp pm02.zerolocal.jp tr.zerolocal.jp factoring.zerolocal.jp tuka.zerolocal.jp manager.zerolocal.jp z.zerolocal.jp www.zeroweb.jp ssl.zeroweb.co.jp bsd.zerolocal.jp hobbit.zerolocal.jp zeus.zerolocal.jp app2.zeus.zerolocal.jp web00.xtend.jp www1.xtend.jp www2.xtend.jp www3.xtend.jp ns.xtend.jp x-click.xtend.jp hobbit.xtend.jp www4.xtend.jp mail00.xtend.jp mail01.xtend.jp storage00.zerolocal.jp storage01.zerolocal.jp)

fpath=($fpath ~/.zsh/functions)

autoload -U compinit
compinit -u

autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^Z' predict-on
bindkey '^Z' predict-off
zstyle ':predict' verbose true

eval `dircolors ~/.zsh/.dircolors`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:cd:*' tag-order local-directories path-directories
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


