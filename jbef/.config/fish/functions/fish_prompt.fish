function fish_prompt
    set -l __last_command_exit_status $status

    # if not set -q -g __fish_arrow_functions_defined
    #     set -g __fish_arrow_functions_defined
    #     function _git_branch_name
    #         set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
    #         if set -q branch[1]
    #             echo (string replace -r '^refs/heads/' '' $branch)
    #         else
    #             echo (git rev-parse --short HEAD 2>/dev/null)
    #         end
    #     end
    #
    #     function _is_git_dirty
    #         not command git diff-index --cached --quiet HEAD -- &>/dev/null
    #         or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
    #     end
    #
    #     function _is_git_repo
    #         type -q git
    #         or return 1
    #         git rev-parse --git-dir >/dev/null 2>&1
    #     end
    #
    #     function _hg_branch_name
    #         echo (hg branch 2>/dev/null)
    #     end
    #
    #     function _is_hg_dirty
    #         set -l stat (hg status -mard 2>/dev/null)
    #         test -n "$stat"
    #     end
    #
    #     function _is_hg_repo
    #         fish_print_hg_root >/dev/null
    #     end
    #
    #     function _repo_branch_name
    #         _$argv[1]_branch_name
    #     end
    #
    #     function _is_repo_dirty
    #         _is_$argv[1]_dirty
    #     end
    #
    #     function _repo_type
    #         if _is_hg_repo
    #             echo hg
    #             return 0
    #         else if _is_git_repo
    #             echo git
    #             return 0
    #         end
    #         return 1
    #     end
    # end

    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l blue (set_color blue)

    set -l gray (set_color grey)
    set -l pink (set_color magenta)
    set -l mauve (set_color red)

    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
        set arrow " "
    end

    switch $fish_bind_mode
      case default
        set arrow_color (set_color normal)(set_color blue)
        set arrow "❮ "
      case insert
        set arrow_color (set_color normal)(set_color green)
        set arrow "❯ "
      case replace_one
        set arrow_color (set_color normal)(set_color magenta)
        set arrow "◉ "
      case replace
        set arrow_color (set_color normal)(set_color magenta)
        set arrow "◉ "
      case visual
        set arrow_color (set_color normal)(set_color magenta)
        set arrow "❯ "
      case '*'
        set arrow_color (set_color normal)(set_color red)
        set arrow "❯ "
    end

    set -l arrow "$arrow_color$arrow$normal"
    if fish_is_root_user
        set arrow "# $arrow_color"
    end

    set -g fish_prompt_pwd_full_dirs 2
    set -g fish_prompt_pwd_dir_length 4

    # set -l cwd $blue(prompt_pwd)
    set -l cwd (set_color -o -d cyan)(prompt_pwd)

    # set -l repo_info
    # if set -l repo_type (_repo_type)
    #     set -l repo_branch $gray(_repo_branch_name $repo_type)
    #     # set repo_info "$gray $repo_type:($repo_branch)"
    #     set repo_info "$gray 󰧟$repo_branch"
    #
    #     if _is_repo_dirty $repo_type
    #         set -l dirty "$mauve*"
    #         set repo_info "$repo_info$dirty"
    #     end
    # end

    # echo -n -s $cwd $repo_info $normal \n\r $arrow
    echo -n -s \n\r$cwd (set_color normal)(fish_git_prompt) \n\r $arrow
end

