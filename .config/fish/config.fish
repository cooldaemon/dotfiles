set -gx fish_escape_delay_ms 10
source $HOME/.config/fish/alias.fish

eval "$(/opt/homebrew/bin/brew shellenv)"

if test -f (brew --prefix asdf)/libexec/asdf.fish
  source (brew --prefix asdf)/libexec/asdf.fish
end

# For Erlang
if test -d (brew --prefix openjdk)/bin
  set -gx PATH (brew --prefix openjdk)/bin $PATH
end

set -x KERL_CONFIGURE_OPTIONS --with-ssl=(brew --prefix openssl@3) --with-odbc=(brew --prefix unixodbc)
set -x CC /usr/bin/gcc -I(brew --prefix unixodbc)/include
set -x LDFLAGS -L(brew --prefix unixodbc)/lib

# For nodejs
if test -d (brew --prefix gawk)/libexec/gnubin
  set -gx PATH (brew --prefix gawk)/libexec/gnubin $PATH
end
