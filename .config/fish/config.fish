command -q lvim && alias vim='lvim'
command -q eza && alias ls='eza -a --icons'
alias cp='cp -i'
alias mv='mv -i'
alias open='xdg-open 2>/dev/null'
alias copy='xclip -selection c'
alias vimf='fd -H -t f . ~ | fzf -i | xargs -ro $EDITOR'
alias cdf='cd (fd -H -t d . ~ | fzf -i)'
alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
function run; NIXPKGS_ALLOW_UNFREE=1 nix run nixpkgs#$argv[1]; end
alias edit='$EDITOR /etc/nixos/configuration.nix'
alias rebuild='git -C /etc/nixos add -A \
               && sudo nixos-rebuild switch --flake /etc/nixos#default \
               && git -C /etc/nixos commit -m (nixos-rebuild list-generations | grep current)'

fish_add_path ~/Backups/scripts

set fish_prompt_pwd_dir_length 3
set fish_greeting

set -x SHELL (which fish)
set -x EDITOR (which vi)
command -q lvim && set -x EDITOR (which lvim)
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

fish_vi_key_bindings

bind -M insert \el 'forward-word'   # alt-L to accept next autocomplete word
bind -M insert \ej 'down-or-search' # alt-J/K history navigation
bind -M insert \ek 'up-or-search'   # alt-J/K history navigation
bind -M insert \cr 'history-pager'  # re-bind history shortcut for vi mode
