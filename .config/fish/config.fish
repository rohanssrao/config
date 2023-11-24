alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias restartdm='sudo systemctl restart display-manager'
alias open='xdg-open 2>/dev/null'
alias cp='cp -i'
alias mv='mv -i'
alias copy='xclip -selection c'
alias ls='exa -a --icons'
alias lg='lazygit'
alias vim='lvim'
alias fzfd='fd -H --type d . ~ | fzf -i'
alias vimf='vim (fd -H --type f . ~ | fzf -i)'
alias cdf='cd (fzfd)'
alias YEP='yes'
alias neofetch='neowofetch'
alias docker='podman'

alias meld='flatpak run org.gnome.meld'

# Alt-L to accept single word from autocomplete
bind \el forward-word
# Vim-style history navigation
bind \ek 'up-or-search'
bind \ej 'down-or-search'

set fish_prompt_pwd_dir_length 3
set fish_greeting

set -x SHELL "$(which fish)"
set -x EDITOR "$(which lvim)"
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_STATE_HOME "$HOME/.local/state"
set -x XDG_CACHE_HOME "$HOME/.cache"

####### Vi Mode ########
#fish_vi_key_bindings
#bind -M default yy fish_clipboard_copy
#bind -M default p fish_clipboard_paste
######## Undo ##########
fish_default_key_bindings
