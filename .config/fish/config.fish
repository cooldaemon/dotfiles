set -gx fish_escape_delay_ms 10
source $HOME/.config/fish/alias.fish

eval "$(/opt/homebrew/bin/brew shellenv)"

# For gawk
if test -d (brew --prefix gawk)/libexec/gnubin
  set -gx PATH (brew --prefix gawk)/libexec/gnubin $PATH
end

# For PostgreSQL@13
if test -d (brew --prefix postgresql@13)/bin
  set -gx PATH (brew --prefix postgresql@13)/bin $PATH
end

# For direnv
if command -v direnv > /dev/null
  set -g direnv_fish_mode eval_on_arrow
  direnv hook fish | source
end
