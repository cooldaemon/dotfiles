path=(~/bin(N) /usr/local/bin(N) /usr/local/*/bin(N) $path)
typeset -U path

manpath=($manpath /opt/local/man(N))
typeset -U manpath

export SVN_EDITOR=vi

if [ `uname` = 'Darwin' ]; then
  export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/local/include
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/local/lib
  export LANG=ja_JP.UTF-8
  export JAVA_OPTS='-Xmx256M -Xms32M -Dfile.encoding=UTF-8'
  export GOPATH=~/gocode
  path=(~/Library/Haskell/bin(N) /opt/local/bin(N) /opt/local/sbin(N) $path)
fi

 # for android
if [ `uname` = 'Darwin' ]; then
  if [ -e /usr/local/adt-bundle-mac/ ]; then
    export ANDROID_HOME=/usr/local/adt-bundle-mac/sdk
    export ANDROID_SDK_HOME=/usr/local/adt-bundle-mac/sdk
    path=(/usr/local/adt-bundle-mac/sdk/tools(N) /usr/local/adt-bundle-mac/sdk/platform-tools(N) /usr/local/android-ndk-r8c(N) $path)
  fi
fi

# for aws
if [ -e /usr/local/etc/awscli.conf ]; then
  export AWS_CONFIG_FILE=/usr/local/etc/awscli.conf
fi

# for google
if [ -e ~/google-cloud-sdk/ ]; then
  source ~/google-cloud-sdk/path.zsh.inc
fi

# for mysql sandbox and ack
if [ `uname` = 'Darwin' ]; then
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
fi
