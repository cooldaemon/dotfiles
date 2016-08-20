path=(~/bin(N) /usr/local/bin(N) /opt/local/bin(N) /opt/local/sbin(N) /usr/local/*/bin(N) $path)
typeset -U path

manpath=($manpath /opt/local/man(N))
typeset -U manpath

export SVN_EDITOR=vi

if [ `uname` = 'Darwin' ]; then
  if [ -z $C_INCLUDE_PATH ]; then
    export C_INCLUDE_PATH=/opt/local/include:$C_INCLUDE_PATH
  else
    export C_INCLUDE_PATH=/opt/local/include:/usr/include:/usr/local/include
  fi

  if [ -z $LD_LIBRARY_PATH ]; then
    export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
  else
    export LD_LIBRARY_PATH=/opt/local/lib:/usr/lib:/usr/local/lib
  fi

  export LANG=ja_JP.UTF-8
  export JAVA_OPTS='-Xmx256M -Xms32M -Dfile.encoding=UTF-8'
  path=(~/Library/Haskell/bin(N) $path)
  export GOPATH=~/gocode
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
    eval "$(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)"
fi

# anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH="${HOME}/.anyenv/bin:${PATH}"
    eval "$(anyenv init -)"
fi
