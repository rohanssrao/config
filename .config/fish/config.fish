alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias restartdm='sudo systemctl restart display-manager'
alias open='xdg-open 2>/dev/null'
alias cp='cp -i'
alias mv='mv -i'
alias ls='exa -a --icons'
alias cat='bat'
alias vim='lvim'
alias fzfd='fd -H --type d . ~ | fzf'
alias vimf='vim (fd -H --type f . ~ | fzf)'
alias cdf='cd (fzfd)'
alias YEP='yes'
alias neofetch='neowofetch'
alias docker='podman'

alias meld='flatpak run org.gnome.meld'

# Alt-L to accept single word from autocomplete
bind \el forward-word

any-nix-shell fish --info-right | source

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
