export SVN_EDITOR=vi
export PATH=~/bin:/usr/local/bin:$PATH

if [ `uname` = 'Darwin' ]; then
  export PATH=/opt/local/bin:/usr/local/flex_sdk3/bin:$PATH
  export MANPATH=$MANPATH:/opt/local/man
  export LANG=ja_JP.UTF-8
fi

