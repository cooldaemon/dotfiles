if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet head -module(".st.et.").<CR>-author('cooldaemon@gmail.com').<CR><CR>-export([".st.et."]).<CR><CR>".st.et

exec "Snippet mod -module([".st.et."]).<CR>"
exec "Snippet auth -author('cooldaemon@gmail.com').<CR>"
exec "Snippet beh -behaviour(".st.et.").<CR>"
exec "Snippet exp -export([".st.et."]).<CR>"
exec "Snippet comp -compile(".st."export_all".et.").<CR>"
exec "Snippet inc -include(\"".st.et."\").<CR>"
exec "Snippet incl -include_lib(\"".st.et."\").<CR>"
exec "Snippet def -define(".st."NAME".et.", ".st.et.").<CR>"
exec "Snippet rec -record(".st."name".et.", {".st.et."}).<CR>"

exec "Snippet fun fun (".st.et.") -> ".st.et." end"
exec "Snippet func ".st.et."(".st.et.") -> ".st.et." end"
exec "Snippet let (fun (".st."arg".et.") -> ".st.et." end)(".st."arg".et.")."

exec "Snippet case case ".st.et." of<CR>".st.et." -> ".st.et.";<CR>_ -> ".st.et."<CR>end"
exec "Snippet if if<CR>".st.et." -> ".st.et.";<CR>".st."true".et." -> ".st.et."<CR>end"
exec "Snippet recv receive<CR>".st.et." -> ".st.et.";<CR>_ -> ".st.et."<CR>after<CR>".st."TIMEOUT".et." -> ".st.et."<CR>end"

exec "Snippet for lists:foreach(fun (".st."X".et.") -> ".st.et." end, ".st.et.")"
exec "Snippet map lists:map(fun (".st."X".et.") -> ".st.et." end, ".st.et.")"
exec "Snippet any lists:any(fun (".st."X".et.") -> ".st.et." end, ".st.et.")"
exec "Snippet list [".st."X".et." || ".st."X".et." <- ".st.et."]"

exec "Snippet say io:fwrite(\"".st.et."~n\", [".st.et."])"
exec "Snippet spawn spawn(".st.et.", ".st.et.", [".st.et."])"
exec "Snippet spawn_link spawn_link(".st.et.", ".st.et.", [".st.et."])"
exec "Snippet register register(".st."name".et.", ".st."Pid".et.")"
exec "Snippet process_flag process_flag(trap_exit, true)"

