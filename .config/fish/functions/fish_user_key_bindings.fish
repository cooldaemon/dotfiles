set fish_plugins theme peco

function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_default_key_bindings -M default
    fish_default_key_bindings -M visual

    fish_vi_key_bindings --no-erase

    bind -M insert \cr 'peco_select_history (commandline -b)'
    ### expand ###
    bind --sets-mode expand \t expand_execute
    bind --mode expand --sets-mode default --key backspace expand_revert
    bind --mode expand \t expand_choose-next
    bind --mode expand --sets-mode default '' ''
    ### expand ###
end
