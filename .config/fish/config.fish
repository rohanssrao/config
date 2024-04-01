if command -q lvim; alias vim='lvim'; end
if command -q eza; alias ls='eza -a --icons'; end
alias cp='cp -i'
alias mv='mv -i'
alias vimf='fd -H -t f . ~ | fzf --preview "bat -n --color=always {}" | xargs -ro $EDITOR'
alias cdf='cd (fd -H -t d . ~ | fzf --preview "ls --color=always {}")'
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias open='xdg-open 2>/dev/null'
alias copy='xclip -selection c'

set -x SHELL (command -v fish)
set -x EDITOR (command -v vi)
if command -q lvim; set -x EDITOR (command -v lvim); end
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

set fish_prompt_pwd_dir_length 3
set fish_greeting

fish_add_path ~/Backups/scripts
fish_vi_key_bindings

bind -M insert \el 'forward-word'          # alt-l to accept next autocomplete word
bind -M insert \ej 'down-or-search'        # alt-j/k history navigation
bind -M insert \ek 'up-or-search'          # alt-j/k history navigation
bind -M insert \cr 'history-pager'         # re-bind (vi mode)
bind -M insert \cf 'accept-autosuggestion' # re-bind (vi mode)
