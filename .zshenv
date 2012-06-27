path=(~/bin(N) /usr/local/bin(N) /opt/local/bin(N) /opt/local/sbin(N) /usr/local/*/bin(N) $path)
typeset -U path

manpath=($manpath /opt/local/man(N))
typeset -U manpath

export SVN_EDITOR=vi

if [ `uname` = 'Darwin' ]; then
  export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/local/include
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib
  export LANG=ja_JP.UTF-8
  export JAVA_OPTS='-Xmx256M -Xms32M -Dfile.encoding=UTF-8'
fi

