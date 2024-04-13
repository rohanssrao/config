alias cp='cp -i'
alias mv='mv -i'
alias copy='xclip -selection c'
alias open='xdg-open 2>/dev/null'
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cdf='cd (fd -H -t d . ~ | fzf --preview "ls --color=always {}")'
alias vimf='fd -H -t f . ~ | fzf --preview "bat -n --theme=Nord --color=always {}" | xargs -ro $EDITOR'
if command -q lvim; alias vim='lvim'; end
if command -q eza; alias ls='eza -a --icons'; end

set -x SHELL (command -v fish)
set -x EDITOR (command -v vi)
if command -q lvim; set -x EDITOR (command -v lvim); end
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

set fish_prompt_pwd_dir_length 3
set fish_greeting

fish_add_path ~/Backups/scripts

fish_vi_key_bindings

# \e = alt, \c = ctrl
bind -M insert \el 'forward-word'
bind -M insert \ej 'down-or-search'
bind -M insert \ek 'up-or-search'
bind -M insert \cr 'history-pager'
bind -M insert \cf 'accept-autosuggestion'
bind yy fish_clipboard_copy
bind p fish_clipboard_paste
