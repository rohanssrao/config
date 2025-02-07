alias cp='cp -i'
alias mv='mv -i'
alias copy='xclip -sel c'
alias open='xdg-open 2>/dev/null'
alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'
if command -q eza; alias ls='eza -a --icons'; end

function cd; builtin cd $argv && ls; end
function cdf
  set dir (fd -H -t d . ~ | fzf --height=10 --reverse)
  if [ -n "$dir" ]; commandline "cd \"$dir\""; commandline -f execute; end
end
function vimf
  set file (fd -H -t f . ~ | fzf --height=10 --reverse)
  if [ -n "$file" ]; commandline "$EDITOR \"$file\""; commandline -f execute; end
end

# trim nix store paths
if test $SHLVL = 1
  set PATH (for dir in $PATH; if not string match -q "/nix/store/*" $dir; echo $dir; end; end)
end

fish_add_path ~/.local/bin

set fish_greeting

# \e = alt, \c = ctrl
set -g fish_vi_key_bindings
bind -M insert \el 'forward-word'
bind -M insert \ej 'down-or-search'
bind -M insert \ek 'up-or-search'
bind -M insert \cr 'history-pager'
bind -M insert \cf 'accept-autosuggestion'
bind yy fish_clipboard_copy
bind p fish_clipboard_paste
