alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias open='xdg-open 2>/dev/null'
alias cp='cp -i'
alias mv='mv -i'
alias copy='xclip -selection c'
alias ls='eza -a --icons'
alias lg='lazygit'
alias vim='lvim'
alias fzfd='fd -H --type d --max-depth 7 . ~ | fzf -i'
alias vimf='vim (fd -H --type f --max-depth 7 . ~ | fzf -i || echo \'--version\')'
alias cdf='cd (fzfd)'
alias YEP='yes'
alias restartdm='sudo systemctl restart display-manager'
alias meld='flatpak run org.gnome.meld'

bind \el forward-word # alt-L to accept single word from autocomplete
bind \ej 'down-or-search' # vim-style history navigation
bind \ek 'up-or-search'

set fish_prompt_pwd_dir_length 3 # lengthen prompt
set fish_greeting # clear greeting

fish_add_path ~/Backups/scripts

set -x SHELL "(which fish)"
set -x EDITOR "(which lvim)"
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_CACHE_HOME "$HOME/.cache"

####### vi mode ########
#fish_vi_key_bindings
#bind -M default yy fish_clipboard_copy
#bind -M default p fish_clipboard_paste
######## undo ##########
#fish_default_key_bindings
