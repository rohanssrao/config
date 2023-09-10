{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
  
    fish
    neovim
      xclip
      python311Packages.flake8
    hyfetch
    gcc
    fd
    ripgrep
    exa
    bat
    age
    lolcat
    github-copilot-cli
    any-nix-shell
    obsidian
		direnv
		corefonts

    gnomeExtensions.appindicator
    gnomeExtensions.arcmenu
    gnomeExtensions.blur-my-shell
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.disable-workspace-switch-animation-for-gnome-40
    gnomeExtensions.gesture-improvements
    gnomeExtensions.just-perfection
    gnomeExtensions.removable-drive-menu
    #gnomeExtensions.gsconnect
		#gnomeExtensions.user-themes
    
    
  ];

  home.username = "chika";
  home.homeDirectory = "/home/chika";

  home.stateVersion = "23.05"; # Don't change

  programs.home-manager.enable = true;

	news.display = "silent";

}
