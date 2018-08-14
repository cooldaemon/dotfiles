function cdd
  set -l i (echo $argv | cut -d ':' -f 1)
  cd $_cdd_pwd[(math $i + 1)]
end

function __cdd_complete
  for i in (seq (count $_cdd_pwd))
    set -l path $_cdd_pwd[$i]
    test $path; and echo (math $i - 1):$path
  end
end

complete -c cdd -a '(__cdd_complete)' -f

function cdd_init
  test $STY;  and __cdd_init_screen
  test $TMUX; and __cdd_init_tmux
end

function __cdd_init_screen
  function __cdd_register_pwd --on-variable PWD
    set -U _cdd_pwd[(math $WINDOW + 1)] $PWD
  end

  function __cdd_unregister --on-process-exit %self
    set -U _cdd_pwd[(math $WINDOW + 1)] ''
  end
end

function __cdd_init_tmux
  set -g WINDOW (tmux respawn-window 2>&1 | cut -d ':' -f 3)
  __cdd_init_screen
end
