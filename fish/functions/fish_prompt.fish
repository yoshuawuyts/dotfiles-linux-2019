function fish_prompt
  set_color blue
  printf '\n[%s]' (basename $PWD)
  set_color normal
  printf ' %s' (git-branch-status)

  set_color $fish_color_cwd
  printf '\n$ '
  set_color normal
end
