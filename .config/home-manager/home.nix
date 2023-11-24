{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
  
    fish
    neovim
      python311Packages.flake8
			xclip
    hyfetch
		exa
    gcc
    fd
    ripgrep
    bat
    age
    lolcat
		powertop
		lazygit
		corefonts

    # gnomeExtensions.appindicator
    # gnomeExtensions.arcmenu
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.brightness-control-using-ddcutil
    # gnomeExtensions.disable-workspace-switch-animation-for-gnome-40
    # gnomeExtensions.gesture-improvements
    # gnomeExtensions.just-perfection
    # gnomeExtensions.removable-drive-menu
    # gnomeExtensions.gsconnect
		# gnomeExtensions.user-themes
		xorg.xinput
		xdotool
    
  ];

  home.username = "chika";
  home.homeDirectory = "/home/chika";

  home.stateVersion = "23.05"; # Don't change

  programs.home-manager.enable = true;

	news.display = "silent";

}
