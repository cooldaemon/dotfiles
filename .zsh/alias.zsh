# common
alias -g lG='| grep'
alias -g lM='| more'
alias -g lX='| xargs'

alias sudo='sudo -E '
alias tm='tmux -2 attach-session || tmux -2'
alias v='vim'
alias g='git'
alias cdgr='git rev-parse --is-inside-work-tree > /dev/null 2>&1 && cd $(git rev-parse --show-cdup)'

alias l='ls'
alias la='ls -A'
alias ll='ls -lA'
alias lt='ll -ct'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias h='history'
alias ha='h -E 1'
alias du='du -h'
alias df='df -h'
alias j='jobs'

alias p='perl'
alias e='erl'
alias s='scala'

source ~/bin/cdd

# mac
if [ `uname` = 'Darwin' ]; then
    alias fcd='source ~/bin/fcd.sh'
    alias gv='open -a /Applications/MacVim.app'
    alias ls='gls -F --color=auto'
    alias mxmlc='mxmlc -compiler.source-path+=.'

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

