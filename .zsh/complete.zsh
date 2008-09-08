# complet & color

_cache_hosts=(svn.zerolocal.jp pubmail.zerolocal.jp tr.zerolocal.jp factoring.zerolocal.jp tuka.zerolocal.jp manager.zerolocal.jp z.zerolocal.jp www.zeroweb.jp ssl.zeroweb.co.jp bsd.zerolocal.jp hobbit.zerolocal.jp zeus.zerolocal.jp app2.zeus.zerolocal.jp www1.xtend.co.jp www2.xtend.co.jp www3.xtend.co.jp ns.xtend.co.jp gajiro.xtend.co.jp p-ne.xtend.co.jp x-click.xtend.co.jp hobbit.xtend.co.jp www4.xtend.co.jp)

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

function  _cap () {
  `cap -T | grep '^cap ' | sed 's/^cap //' | sed 's/ .*//' | sed 's/^/compadd /'`
}
compdef _cap cap

