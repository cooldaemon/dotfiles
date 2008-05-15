if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

" header
let perl_header = "use strict;<CR>use warnings;<CR>use feature qw(:5.10);<CR><CR>use version; our $VERSION = qv('0.0.1');<CR><CR>use Carp;<CR>use English qw(-no_match_vars);<CR><CR>"
exec "Snippet head ".perl_header.st.et
exec "Snippet phead package ".st.et.";<CR><CR>".perl_header
exec "Snippet shead #!/usr/bin/env perl<CR>\<BS><CR>".perl_header.st.et

" sub
exec "Snippet sub sub ".st.et." {<CR>    ".st.et."<CR>}<CR>"
exec "Snippet suba sub ".st.et." {<CR>    my (".st.et.") = @_;<CR><CR><CR>}<CR>"
exec "Snippet subc sub ".st.et." {<CR>    my \$self = shift;<CR>    my (".st.et.") = @_;<CR><CR><CR>}<CR>"

" loop
exec "Snippet for for my \$".st.et." (".st.et.") {<CR><CR>}<CR>"
exec "Snippet forgv for my \$".st.et." (".st.et.") {<CR>when (".st.et.") {}<CR>default {}<CR>}"
exec "Snippet while while (".st.et.") {<CR><CR>}<CR>"

exec "Snippet map map {".st.et."}"
exec "Snippet grep grep {".st.et."}"
exec "Snippet sort sort {".st.et."}"

" if
exec "Snippet if if (".st.et.") {<CR><CR>}<CR>"
exec "Snippet un unless (".st.et.") {<CR><CR>}<CR>"

exec "Snippet ifee if (".st.et.") {<CR><CR>} elsif (".st.et.") {<CR><CR>} else {<CR><CR>}<CR>"
exec "Snippet ife if (".st.et.") {<CR><CR>} else {<CR><CR>}<CR>"

exec "Snippet gv given (".st.et.") {<CR>when (".st.et.") {}<CR>default {}<CR>}"

" catalyst
exec "Snippet csub sub ".st.et." : ".st.et." {<CR>    my (\$self, \$c,) = @_;<CR><CR>    ".st.et."<CR>}<CR>"

exec "Snippet param $c->req->param(".st.et.")"
exec "Snippet stash $c->stash->{".st.et."}"
exec "Snippet conf $c->config->{".st.et."}"
exec "Snippet ses $c->session->{".st.et."}"

exec "Snippet haserr $c->form->has_error".st.et
exec "Snippet seterr $c->set_invalid_form(".st.et.");"

exec "Snippet fw $c->forward('".st.et."');"
exec "Snippet dt $c->detach('".st.et."');"

exec "Snippet model $c->model('".st.et."');"
exec "Snippet find $c->model('".st.et."')->find(".st.et.");"
exec "Snippet search $c->model('".st.et."')->search({".st.et."},);"
exec "Snippet count $c->model('".st.et."')->count({".st.et."},);"
exec "Snippet create $c->model('".st.et."')->create({".st.et."});"

exec "Snippet dump $c->log->dumper([".st.et."]);"

" etc
exec "Snippet eval eval {<CR>".st.et."<CR>};<CR>if ($@) {<CR><CR>}<CR>"
" exec "Snippet say print ".st.et.", \"\\n\";"

