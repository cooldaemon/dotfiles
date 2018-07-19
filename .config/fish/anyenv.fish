if test -z $TMUX
  set -x PATH $HOME/.anyenv/bin $PATH
  string replace "setenv" "set -gx" (anyenv init - fish) | source
end
