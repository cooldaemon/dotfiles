umask 002
cdpath=(~)

if [ `uname` = 'Darwin' ]; then
  test -r /sw/bin/init.sh && . /sw/bin/init.sh
fi

setopt AUTOPUSHD
setopt PUSHD_IGNORE_DUPS
setopt AUTO_CD
setopt CDABLEVARS

for file in env bindkey prompt complete history screen alias; do
  [ -f ~/.zsh/.zshrc.$file ]; source ~/.zsh/.zshrc.$file
done

