alias vim='lvim'
alias cp='cp -i'
alias mv='mv -i'
alias ls='eza -a --icons'
alias vimf='fd -H -t f . ~ | fzf -i | xargs -ro $EDITOR'
alias cdf='cd (fd -H -t d . ~ | fzf -i)'
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if [ (uname) = "Linux" ]
  alias open='xdg-open 2>/dev/null'
  alias copy='xclip -selection c'
end

fish_add_path ~/Backups/scripts

set fish_prompt_pwd_dir_length 3
set fish_greeting

set -x SHELL (which fish)
set -x EDITOR (which lvim)
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

fish_vi_key_bindings

bind -M insert \el 'forward-word'   # alt-L to accept next autocomplete word
bind -M insert \ej 'down-or-search' # alt-J/K history navigation
bind -M insert \ek 'up-or-search'
bind -M insert \cr 'history-pager'  # re-bind history shortcut
