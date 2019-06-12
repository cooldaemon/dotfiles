function ssh --wraps ssh
  set -l org_term $TERM
  set TERM vt100
  command ssh $argv
  set TERM $org_term
end

function cdgr
  git rev-parse --is-inside-work-tree ^/dev/null >/dev/null

  if test $status -ne 0
    return 1
  end

  cd (git rev-parse --show-cdup)
end

function memo
  set filename $argv[1]_(date -jn +%Y-%m-%d).md

  if type idea > /dev/null 2>&1
    set editor idea
    touch $filename
  else
    set editor nvim
  end

  eval $editor $filename
end

alias grep 'grep --color'
alias sudo 'sudo -E'
alias tm tmux
alias v nvim
alias vi nvim
alias e 'emacs -nw'
alias g git

alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

alias h history
alias ha 'history -E 1'
alias du 'du -h'
alias df 'df -h'
alias j jobs
