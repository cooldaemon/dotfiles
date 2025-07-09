function ssh --wraps ssh
  set -l org_term $TERM
  set TERM vt100
  command ssh $argv
  set TERM $org_term
end

alias grep 'grep --color'
alias sudo 'sudo -E'
alias v vi
alias c claude
alias e cursor
alias g git
alias t tmux

alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

alias h history
alias ha 'history -E 1'
alias du 'du -h'
alias df 'df -h'
alias j jobs
