# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_jj_global_optspecs
	string join \n R/repository= ignore-working-copy ignore-immutable at-operation= debug color= quiet no-pager config= config-toml= config-file= h/help V/version
end

function __fish_jj_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_jj_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_jj_using_subcommand
	set -l cmd (__fish_jj_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c jj -n "__fish_jj_needs_command" -s R -l repository -d 'Path to repository to operate on' -r -f -a "(__fish_complete_directories)"
complete -c jj -n "__fish_jj_needs_command" -l at-operation -l at-op -d 'Operation to load the repo at' -r
complete -c jj -n "__fish_jj_needs_command" -l color -d 'When to colorize output' -r -f -a "always\t''
never\t''
debug\t''
auto\t''"
complete -c jj -n "__fish_jj_needs_command" -l config -d 'Additional configuration options (can be repeated)' -r
complete -c jj -n "__fish_jj_needs_command" -l config-toml -d 'Additional configuration options (can be repeated) (DEPRECATED)' -r
complete -c jj -n "__fish_jj_needs_command" -l config-file -d 'Additional configuration files (can be repeated)' -r -F
complete -c jj -n "__fish_jj_needs_command" -l ignore-working-copy -d 'Don\'t snapshot the working copy, and don\'t update it'
complete -c jj -n "__fish_jj_needs_command" -l ignore-immutable -d 'Allow rewriting immutable commits'
complete -c jj -n "__fish_jj_needs_command" -l debug -d 'Enable debug logging'
complete -c jj -n "__fish_jj_needs_command" -l quiet -d 'Silence non-primary command output'
complete -c jj -n "__fish_jj_needs_command" -l no-pager -d 'Disable the pager'
complete -c jj -n "__fish_jj_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c jj -n "__fish_jj_needs_command" -s V -l version -d 'Print version'
complete -c jj -n "__fish_jj_needs_command" -f -a "abandon" -d 'Abandon a revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "absorb" -d 'Move changes from a revision into the stack of mutable revisions'
complete -c jj -n "__fish_jj_needs_command" -f -a "backout" -d '(deprecated; use `revert`) Apply the reverse of given revisions on top of another revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "bookmark" -d 'Manage bookmarks [default alias: b]'
complete -c jj -n "__fish_jj_needs_command" -f -a "commit" -d 'Update the description and create a new change on top'
complete -c jj -n "__fish_jj_needs_command" -f -a "config" -d 'Manage config options'
complete -c jj -n "__fish_jj_needs_command" -f -a "debug" -d 'Low-level commands not intended for users'
complete -c jj -n "__fish_jj_needs_command" -f -a "describe" -d 'Update the change description or other metadata'
complete -c jj -n "__fish_jj_needs_command" -f -a "desc" -d 'Update the change description or other metadata'
complete -c jj -n "__fish_jj_needs_command" -f -a "diff" -d 'Compare file contents between two revisions'
complete -c jj -n "__fish_jj_needs_command" -f -a "diffedit" -d 'Touch up the content changes in a revision with a diff editor'
complete -c jj -n "__fish_jj_needs_command" -f -a "duplicate" -d 'Create new changes with the same content as existing ones'
complete -c jj -n "__fish_jj_needs_command" -f -a "edit" -d 'Sets the specified revision as the working-copy revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "evolog" -d 'Show how a change has evolved over time'
complete -c jj -n "__fish_jj_needs_command" -f -a "evolution-log" -d 'Show how a change has evolved over time'
complete -c jj -n "__fish_jj_needs_command" -f -a "file" -d 'File operations'
complete -c jj -n "__fish_jj_needs_command" -f -a "fix" -d 'Update files with formatting fixes or other changes'
complete -c jj -n "__fish_jj_needs_command" -f -a "git" -d 'Commands for working with Git remotes and the underlying Git repo'
complete -c jj -n "__fish_jj_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c jj -n "__fish_jj_needs_command" -f -a "interdiff" -d 'Compare the changes of two commits'
complete -c jj -n "__fish_jj_needs_command" -f -a "log" -d 'Show revision history'
complete -c jj -n "__fish_jj_needs_command" -f -a "new" -d 'Create a new, empty change and (by default) edit it in the working copy'
complete -c jj -n "__fish_jj_needs_command" -f -a "next" -d 'Move the working-copy commit to the child revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "operation" -d 'Commands for working with the operation log'
complete -c jj -n "__fish_jj_needs_command" -f -a "op" -d 'Commands for working with the operation log'
complete -c jj -n "__fish_jj_needs_command" -f -a "parallelize" -d 'Parallelize revisions by making them siblings'
complete -c jj -n "__fish_jj_needs_command" -f -a "prev" -d 'Change the working copy revision relative to the parent revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "rebase" -d 'Move revisions to different parent(s)'
complete -c jj -n "__fish_jj_needs_command" -f -a "resolve" -d 'Resolve conflicted files with an external merge tool'
complete -c jj -n "__fish_jj_needs_command" -f -a "restore" -d 'Restore paths from another revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "revert" -d 'Apply the reverse of the given revision(s)'
complete -c jj -n "__fish_jj_needs_command" -f -a "root" -d 'Show the current workspace root directory (shortcut for `jj workspace root`)'
complete -c jj -n "__fish_jj_needs_command" -f -a "run" -d '(**Stub**, does not work yet) Run a command across a set of revisions.'
complete -c jj -n "__fish_jj_needs_command" -f -a "show" -d 'Show commit description and changes in a revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "sign" -d 'Cryptographically sign a revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "simplify-parents" -d 'Simplify parent edges for the specified revision(s)'
complete -c jj -n "__fish_jj_needs_command" -f -a "sparse" -d 'Manage which paths from the working-copy commit are present in the working copy'
complete -c jj -n "__fish_jj_needs_command" -f -a "split" -d 'Split a revision in two'
complete -c jj -n "__fish_jj_needs_command" -f -a "squash" -d 'Move changes from a revision into another revision'
complete -c jj -n "__fish_jj_needs_command" -f -a "status" -d 'Show high-level repo status'
complete -c jj -n "__fish_jj_needs_command" -f -a "st" -d 'Show high-level repo status'
complete -c jj -n "__fish_jj_needs_command" -f -a "tag" -d 'Manage tags'
complete -c jj -n "__fish_jj_needs_command" -f -a "undo" -d 'Undo an operation (shortcut for `jj op undo`)'
complete -c jj -n "__fish_jj_needs_command" -f -a "unsign" -d 'Drop a cryptographic signature'
complete -c jj -n "__fish_jj_needs_command" -f -a "util" -d 'Infrequently used commands such as for generating shell completions'
complete -c jj -n "__fish_jj_needs_command" -f -a "version" -d 'Display version information'
complete -c jj -n "__fish_jj_needs_command" -f -a "workspace" -d 'Commands for working with workspaces'