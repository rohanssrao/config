set -g fish_prompt_pwd_dir_length 3
set -g segment_separator 
set -q max_package_count_visible_in_prompt; or set -g max_package_count_visible_in_prompt 3
set -q try_to_trim_nix_package_version; or set -g try_to_trim_nix_package_version yes

## Optional
# set -g theme_display_user yes
# set -g theme_hide_hostname yes
# set -g default_user your_normal_user

# ===========================
# Color setting
# ===========================

# Set prompt background to be the same as the terminal. This is bugged on
# VTE terminals so check for VTE_VERSION.
if not set -q VTE_VERSION
  set -g term_bg (sh -c 'read -t 0.1 -rs -d \\\\ -p $\'\\e]11;?\\e\\\\\'; echo $REPLY' | od -An -tc | tr -d ' \n' | awk -F':|/' '{if (length($0)<30) print "#111318"; else print "#" substr($2,1,2) substr($3,1,2) substr($4,1,2)}')
else
  set -g term_bg "#111318"
end
set -q color_vi_mode_normal; or set -g color_vi_mode_normal green
set -q color_vi_mode_insert; or set -g color_vi_mode_insert blue 
set -q color_vi_mode_visual; or set -g color_vi_mode_visual red
set -q color_distro_bg; or set -g color_distro_bg $term_bg
set -q color_distro_str; or set -g color_distro_str blue
set -q color_virtual_env_bg; or set -g color_virtual_env_bg white
set -q color_virtual_env_str; or set -g color_virtual_env_str black
set -q color_user_bg; or set -g color_user_bg brblack
set -q color_user_str; or set -g color_user_str yellow
set -q color_dir_bg; or set -g color_dir_bg blue
set -q color_dir_str; or set -g color_dir_str black
set -q color_git_dirty_bg; or set -g color_git_dirty_bg yellow
set -q color_git_dirty_str; or set -g color_git_dirty_str black
set -q color_git_bg; or set -g color_git_bg green
set -q color_git_str; or set -g color_git_str black
set -q color_status_nonzero_bg; or set -g color_status_nonzero_bg brblack
set -q color_status_nonzero_str; or set -g color_status_nonzero_str red
set -q glyph_status_nonzero; or set -g glyph_status_nonzero "✘"
set -q color_status_superuser_bg; or set -g color_status_superuser_bg brblack
set -q color_status_superuser_str; or set -g color_status_superuser_str yellow
set -q glyph_status_superuser; or set -g glyph_status_superuser "🔒"
set -q color_status_jobs_bg; or set -g color_status_jobs_bg brblack
set -q color_status_jobs_str; or set -g color_status_jobs_str cyan
set -q glyph_status_jobs; or set -g glyph_status_jobs "⚡"
set -q color_status_private_bg; or set -g color_status_private_bg brblack
set -q color_status_private_str; or set -g color_status_private_str purple
set -q glyph_status_private; or set -g glyph_status_private "⚙"

# ===========================
# General VCS settings

set -q fish_vcs_branch_name_length; or set -g fish_vcs_branch_name_length 15

# ===========================
# Git settings
# set -g color_dir_bg red

set -q fish_git_prompt_untracked_files; or set -g fish_git_prompt_untracked_files normal

# ===========================
# Helper methods
# ===========================

set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_char_dirtystate '±'
set -g __fish_git_prompt_char_cleanstate ''

function shorten_branch_name -a branch_name
  set new_branch_name $branch_name

  if test (string length $branch_name) -gt $fish_vcs_branch_name_length
    # Round up length before dot (+0.5)
    # Remove half the length of dots (-1)
    # -> Total offset: -0.5
    set pre_dots_length (math -s0 $fish_vcs_branch_name_length / 2 - 0.5)
    # Round down length after dot (-0.5)
    # Remove half the length of dots (-1)
    # -> Total offset: -1.5
    set post_dots_length (math -s0 $fish_vcs_branch_name_length / 2 - 1.5)
    set new_branch_name (string replace -r "(.{$pre_dots_length}).*(.{$post_dots_length})" '$1..$2' $branch_name)
  end

  echo $new_branch_name
end

function parse_git_dirty
  if [ $__fish_git_prompt_showdirtystate = "yes" ]
    set -l submodule_syntax
    set submodule_syntax "--ignore-submodules=dirty"
    set untracked_syntax "--untracked-files=$fish_git_prompt_untracked_files"
    set git_dirty (command git status --porcelain $submodule_syntax $untracked_syntax 2> /dev/null)
    if [ -n "$git_dirty" ]
        echo -n "$__fish_git_prompt_char_dirtystate"
    else
        echo -n "$__fish_git_prompt_char_cleanstate"
    end
  end
end

# ===========================
# Segments functions
# ===========================

function prompt_segment -d "Function to draw a segment"
  set -l bg
  set -l fg
  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end
  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end
  if [ "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg" ]
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator "
    set_color -b $bg
    set_color $fg
  else
    set_color -b $bg
    set_color $fg
    echo -n " "
  end
  set current_bg $argv[1]
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3] " "
  end
end

function prompt_finish -d "Close open segments"
  if [ -n $current_bg ]
    set_color normal
    set_color $current_bg
    echo -n "$segment_separator "
    set_color normal
  end
  set -g current_bg NONE
end


# ===========================
# Theme components
# ===========================

function prompt_distro -d "Display distro icon"
  if [ (uname) = "Darwin" ]
    set icon ""
  else if [ (uname) = "Linux" ]
    switch (sed -nr 's/^ID=(.*)/\1/p' /etc/os-release)
      case fedora
        set icon ""
      case nixos
        set icon ""
      case ubuntu
        set icon ""
      case arch
        set icon ""
      case kali
        set icon ""
      case debian
        set icon ""
      case '*'
        set icon "󰌽"
      end
  end
  if set -q icon
    prompt_segment $color_distro_bg $color_distro_str $icon
  end
end

function prompt_container -d "Display container name"
  if test -e /run/.containerenv -o -e /.dockerenv
    prompt_segment $color_user_bg $color_user_str "⬢ $CONTAINER_ID"
  end
end

function prompt_virtual_env -d "Display Python or Nix virtual environment"
  set envs

  if test "$CONDA_DEFAULT_ENV"
    set envs $envs "conda[$CONDA_DEFAULT_ENV]"
  end

  if test "$VIRTUAL_ENV"
    set py_env (basename $VIRTUAL_ENV)
    set envs $envs "py[$py_env]"
  end

  # Support for `nix shell` command in nix 2.4+. Only the packages passed on the command line are
  # available in PATH, so it is useful to print them all.
  set nix_packages
  for p in $PATH
    set package_name_version (string match --regex '/nix/store/\w+-([^/]+)/.*' $p)[2]
    if test "$package_name_version"
      set package_name (string match --regex '^(.*)-(\d+(\.\d)+|unstable-20\d{2}-\d{2}-\d{2})' $package_name_version)[2]
      if test "$try_to_trim_nix_package_version" = "yes" -a -n "$package_name"
        set package $package_name
      else
        set package $package_name_version
      end
      if not contains $package $nix_packages
        set nix_packages $nix_packages $package
      end
    end
  end
  if test (count $nix_packages) -gt $max_package_count_visible_in_prompt
    set nix_packages $nix_packages[1..$max_package_count_visible_in_prompt] "..."
  end

  if [ "$IN_NIX_SHELL" = "impure" ]
    # Support for
    #   1) `nix-shell` command 
    #   2) `nix develop` command in nix 2.4+.
    # These commands are typically dumping too many packages into PATH for it be useful to print
    # them. Thus we only print "nix[impure]".
    set envs $envs "nix[impure]"
  else if test "$nix_packages"
    # Support for `nix-shell -p`. Would print "nix[foo bar baz]".
    # We check for this case after checking for "impure" because impure brings too many packages 
    # into PATH.
    set envs $envs "nix[$nix_packages]"
  else if test "$IN_NIX_SHELL"
    # Support for `nix-shell --pure`. Would print "nix[pure]".
    # We check for this case after checking for individual packages because it otherwise might 
    # confuse the user into believing when they are in a pure shell, after they have invoked 
    # `nix shell` from within it.
    set envs $envs "nix[$IN_NIX_SHELL]"
  end

  # Don't label as nix shell if shell level isn't > 1
  if [ "$SHLVL" -le 1 ]; set envs; end

  if test "$envs"
    prompt_segment $color_virtual_env_bg $color_virtual_env_str (string join " " $envs)
  end
end

function prompt_user -d "Display current user if different from $default_user"
  if [ "$theme_display_user" = "yes" ]
    if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
      set USER (whoami)
      get_hostname
      if [ $HOSTNAME_PROMPT ]
        set USER_PROMPT $USER@$HOSTNAME_PROMPT
      else
        set USER_PROMPT $USER
      end
      prompt_segment $color_user_bg $color_user_str $USER_PROMPT
    end
  else
    get_hostname
    if [ $HOSTNAME_PROMPT ]
      prompt_segment $color_user_bg $color_user_str $HOSTNAME_PROMPT
    end
  end
end

function get_hostname -d "Set current hostname to prompt variable $HOSTNAME_PROMPT if connected via SSH"
  set -g HOSTNAME_PROMPT ""
  if [ "$theme_hide_hostname" = "no" -o \( "$theme_hide_hostname" != "yes" -a -n "$SSH_CLIENT" \) ]
    set -g HOSTNAME_PROMPT (uname -n)
  end
end

function prompt_dir -d "Display the current directory"
  prompt_segment $color_dir_bg $color_dir_str (prompt_pwd)
end

function prompt_git -d "Display the current git state"
  set -l ref
  set -l dirty
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set dirty (parse_git_dirty)
    set ref (command git symbolic-ref HEAD 2> /dev/null)
    if [ $status -gt 0 ]
      set -l branch (command git show-ref --head -s --abbrev | head -n1 2> /dev/null)
      set ref "➦ $branch "
    end
    set branch_symbol \uE0A0
    set -l long_branch (echo $ref | sed "s#refs/heads/##")
    set -l branch (shorten_branch_name $long_branch)
    if [ "$dirty" != "" ]
      prompt_segment $color_git_dirty_bg $color_git_dirty_str "$branch_symbol $branch $dirty"
    else
      prompt_segment $color_git_bg $color_git_str "$branch_symbol $branch $dirty"
    end
  end
end

function prompt_status -d "the symbols for a non zero exit status, root and background jobs"
    if [ $RETVAL -ne 0 ]
      prompt_segment $color_status_nonzero_bg $color_status_nonzero_str $glyph_status_nonzero
    end

    if [ "$fish_private_mode" ]
      prompt_segment $color_status_private_bg $color_status_private_str $glyph_status_private
    end

    if [ (id -u $USER) -eq 0 ]
      prompt_segment $color_status_superuser_bg $color_status_superuser_str $glyph_status_superuser
    end

    if [ (jobs -l | wc -l) -gt 0 ]
      prompt_segment $color_status_jobs_bg $color_status_jobs_str $glyph_status_jobs
    end
end

# ===========================
# Apply theme
# ===========================

function fish_prompt
  set -g current_bg NONE
  set -g RETVAL $status
  prompt_distro
  prompt_container
  prompt_status
  prompt_user
  prompt_dir
  prompt_virtual_env
  type -q git; and prompt_git
  prompt_finish
end

function fish_mode_prompt
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set color_distro_str $color_vi_mode_normal
      case insert
        set color_distro_str $color_vi_mode_insert
      case visual
        set color_distro_str $color_vi_mode_visual
    end
  end
end
