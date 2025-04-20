function fish_git_prompt
  echo (set_color -d white)" "(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/')
end
