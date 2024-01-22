alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lg='lazygit'
alias lcfg='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cp='cp -i'
alias mv='mv -i'
alias ls='eza -a --icons'
alias vim='lvim'
alias fzfd='fd -H -t d . ~ | fzf -i'
alias vimf='fd -H -t f . ~ | fzf -i | xargs -ro $EDITOR'
alias cdf='cd (fzfd)'

if [ (uname) = "Linux" ]
	alias open='xdg-open 2>/dev/null'
    alias copy='xclip -selection c'
    alias meld='flatpak run org.gnome.meld'
    set -x XDG_DATA_HOME "$HOME/.local/share"
    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x XDG_STATE_HOME "$HOME/.local/state"
    set -x XDG_CACHE_HOME "$HOME/.cache"
end

fish_add_path ~/Backups/scripts

bind \el forward-word # alt-L to accept single word from autocomplete
bind \ej 'down-or-search' # vim-style history navigation
bind \ek 'up-or-search'

set fish_prompt_pwd_dir_length 3 # lengthen prompt
set fish_greeting # clear greeting

set -x SHELL (which fish)
set -x EDITOR (which lvim)
set -x SUDO_EDITOR "$EDITOR"
set -x VISUAL "$EDITOR"

####### vi mode ########
#fish_vi_key_bindings
#bind -M default yy fish_clipboard_copy
#bind -M default p fish_clipboard_paste
######## undo ##########
#fish_default_key_bindings
