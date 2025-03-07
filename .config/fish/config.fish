alias cp='cp -i'
alias mv='mv -i'
alias copy='xclip -sel c'
alias open='xdg-open 2>/dev/null'
alias cfg='git --git-dir=$HOME/.cfg --work-tree=$HOME'
if command -q eza; alias ls='eza -a --icons'; end

function cd; builtin cd $argv && ls; end
function cdf
  set dir (FZF_DEFAULT_COMMAND='fd -H -t d . ~' fzf --height=10 --reverse)
  if [ -n "$dir" ]; history append "cd \"$dir\""; cd "$dir"; end
end
function vimf
  set file (FZF_DEFAULT_COMMAND='fd -H -t f . ~' fzf --height=10 --reverse)
  if [ -n "$file" ]; history append "$EDITOR \"$file\""; $EDITOR "$file"; end
end

# trim nix store paths
if test $SHLVL = 1
  set PATH (for dir in $PATH; if not string match -q "/nix/store/*" $dir; echo $dir; end; end)
end

fish_add_path ~/.local/bin

set fish_greeting

set -g fish_vi_key_bindings
bind -M insert alt-l 'forward-word'
bind -M insert alt-j 'down-or-search'
bind -M insert alt-k 'up-or-search'
bind -M insert ctrl-r 'history-pager'
bind -M insert ctrl-f 'accept-autosuggestion'
bind yy fish_clipboard_copy
bind p fish_clipboard_paste

fzf --fish | source
