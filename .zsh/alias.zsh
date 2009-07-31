# common
alias -g lG='| grep'
alias -g lT='| tail'
alias -g lH='| head'
alias -g lM='| more'
alias -g lX='| xargs'

alias sc='screen -xR'
alias v='vim'
alias g='git'

alias l='ls'
alias la='ls -A'
alias ll='ls -lA'
alias lt='ll -ct'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias h='fc -l'
alias ha='h -E 1'

alias du='du -h'
alias df='df -h'

alias j='jobs'

alias p='perl'
alias pe='perl -e'
alias pE='perl -E'
alias pcw='perl -cw'

alias e='erl'
alias ec='erlc'

source ~/bin/cdd

# mac
if [ `uname` = 'Darwin' ]; then
    alias fcd='source ~/bin/fcd.sh'
    alias gv='mvim'
    alias ls='gls -F --color=auto'

    function _color_ls() {
        gls -F --color=auto -A;
    }
fi

# FreeBSD
if [ `uname` = 'FreeBSD' ]; then
    alias ls='gnuls -F --color=auto'

    function _color_ls() {
        gnuls -F --color=auto -A;
    }
fi

