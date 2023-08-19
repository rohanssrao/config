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

    gnomeExtensions.appindicator
    gnomeExtensions.arcmenu
    gnomeExtensions.blur-my-shell
    gnomeExtensions.brightness-control-using-ddcutil
    gnomeExtensions.disable-workspace-switch-animation-for-gnome-40
    gnomeExtensions.gesture-improvements
    gnomeExtensions.just-perfection
    gnomeExtensions.user-themes
    gnomeExtensions.removable-drive-menu
    #gnomeExtensions.gsconnect
    
    
  ];

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "chika";
  home.homeDirectory = "/var/home/chika";

  home.stateVersion = "23.05"; # Don't change

}
