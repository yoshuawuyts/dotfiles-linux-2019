function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color green
    case insert
      set_color blue
    case visual
      set_color magenta
  end

  printf '\n[%s]' (basename $PWD)
  set_color normal
end
