set fish_prompt_pwd_dir_length 3
set fish_greeting

alias home='home-manager'
alias flatpaks='$EDITOR ~/.config/home-manager/modules/flatpak/flatpaks.txt'
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
alias box='distrobox enter box -- fish 2> /dev/null'
alias docker='podman'

alias meld='flatpak run org.gnome.meld'
alias code='flatpak run com.visualstudio.code'

bind \el forward-char
any-nix-shell fish --info-right | source

####### Vi Mode ########
#for mode in insert default visual
#    bind -M $mode \cf forward-char
#end
#fish_vi_key_bindings
#bind yy fish_clipboard_copy
#bind Y fish_clipboard_copy
#bind p fish_clipboard_paste
######## Undo ##########
#fish_default_key_bindings
