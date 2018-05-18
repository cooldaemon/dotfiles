# I redefine anyenv initialize script.
# Because official erlenv and exenv initialize script doesn't run.

# anyenv
set ANYENV $HOME/.anyenv
set ANYENVS $ANYENV/envs

set -x PATH $PATH $ANYENV/bin
source $ANYENV/completions/anyenv.fish
function anyenv
  set command $argv[1]
  set -e argv[1]

  command anyenv "$command" $argv
end

# erlenv
set -x ERLENV_ROOT $ANYENVS/erlenv
set -x PATH $PATH $ERLENV_ROOT/bin
set -x PATH $ERLENV_ROOT/shims $PATH
source $ERLENV_ROOT/completions/erlenv.fish
erlenv rehash 2>/dev/null
function erlenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (erlenv "sh-$command" $argv)
  case '*'
    command erlenv "$command" $argv
  end
end

# exenv
set -x EXENV_ROOT $ANYENVS/exenv
set -x PATH $PATH $EXENV_ROOT/bin
set -x PATH $EXENV_ROOT/shims $PATH
exenv rehash 2>/dev/null
function exenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (exenv "sh-$command" $argv)
  case '*'
    command exenv "$command" $argv
  end
end

# pyenv
set -x PYENV_ROOT $ANYENVS/pyenv
set -x PATH $PATH $PYENV_ROOT/bin
set -x PATH $PYENV_ROOT/shims $PATH
set -x PYENV_SHELL fish
source $PYENV_ROOT/completions/pyenv.fish
command pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case activate deactivate rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end
