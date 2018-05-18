function fish_prompt
  set_color brblack
  echo -n '--<'
  set_color purple
  echo -n (pwd)
  set_color brblack
  echo '>--'
  set_color green
  echo -n '% '
  set_color normal
end
