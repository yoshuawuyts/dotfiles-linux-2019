function fish_prompt
  printf ' %s' (git-branch-status)

  set_color $fish_color_cwd
  printf '\n$ '
  set_color normal
end
