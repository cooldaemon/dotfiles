set -gx OMF_PATH $HOME/.local/share/omf
set -gx EDITOR nvim
set -gx fish_escape_delay_ms 10
set fish_theme agnoster

source $HOME/.config/fish/alias.fish

if test -f $HOME/.asdf/asdf.fish
  source $HOME/.asdf/asdf.fish
end

cdd_init
