# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

if [ -e /home/chika/.nix-profile/etc/profile.d/nix.sh ]; then . /home/chika/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

XDG_DATA_DIRS="/home/chika/.nix-profile/share:$XDG_DATA_DIRS"

# Full font hinting
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
