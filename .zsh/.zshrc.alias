# common
alias -g lG='| grep'
alias -g lM='| more'
alias -g lX='| xargs'

alias sc='screen -xR'
alias v='vim'
alias g='git'

alias l='ls'
alias la='ls -a'
alias ll='ls -la'
alias lt='ll -ct'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias h='history'
alias ha='h -E 1'
alias du='du -h'
alias df='df -h'
alias j='jobs'

source ~/bin/cdd

# mac
if [ `uname` = 'Darwin' ]; then
    alias fcd='source ~/bin/fcd.sh'
    alias gv='gvim.sh'
    alias ls='gls -F --color=auto'

    function _color_ls() {
        gls -F --color=auto -a;
    }
fi

# FreeBSD
if [ `uname` = 'FreeBSD' ]; then
    alias ls='gnuls -F --color=auto'

    function _color_ls() {
        gnuls -F --color=auto -a;
    }
fi

