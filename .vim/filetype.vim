"if exists("did_load_filetypes")
"  finish
"endif

" Template Toolkit
au BufNewFile,BufRead *.tt setf tt2html

" Subversion commit file
au BufNewFile,BufRead svk-commit*.tmp setf svk

" Erlang include file
au BufNewFile,BufRead *.hrl setf erlang

" Flex2 file
au BufNewFile,BufRead *.as setf actionscript
au BufNewFile,BufRead *.mxml setf mxml

" Alloy4
au BufNewFile,BufRead *.als setf alloy4
