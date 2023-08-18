# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

if [ -e /var/home/chika/.nix-profile/etc/profile.d/nix.sh ]; then . /var/home/chika/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

XDG_DATA_DIRS="/home/chika/.nix-profile/share:$XDG_DATA_DIRS"
