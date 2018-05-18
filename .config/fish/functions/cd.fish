# cd > ls
function cd
  builtin cd $argv

  if test $status -ne 0
    return 1
  end

  ls
end
