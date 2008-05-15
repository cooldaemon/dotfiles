if !exists('loaded_snippet') || &cp
    finish
endif

source ~/.vim/after/ftplugin/html_snippets.vim

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet wrap [% WRAPPER ".st.et." %]<CR>".st.et."<CR>[% END %]<CR>"
exec "Snippet inc [% INCLUDE ".st.et." %]<CR>"
exec "Snippet block [% BLOCK ".st.et." %]<CR>".st.et."<CR>[% END %]"

exec "Snippet if [% IF ".st.et." %]<CR><CR>[% END %]<CR>"
exec "Snippet ife [% IF ".st.et." %]<CR><CR>[% ELSE %]<CR><CR>[% END %]<CR>"
exec "Snippet un [% UNLESS ".st.et." %]<CR><CR>[% END %]<CR>"

exec "Snippet for  [% FOREACH ".st.et." IN ".st.et." %]<CR>".st.et."<CR>[% END %]"
exec "Snippet while [% WHILE ".st.et." %]<CR><CR>[% END %]<CR>"

