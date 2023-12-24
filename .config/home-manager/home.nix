{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
  
		fish
		neovim
			python311Packages.flake8
			xclip
		fastfetch
		eza
		gcc
		fd
		ripgrep
		bat
		lolcat

	];

	home.username = "chika";
	home.homeDirectory = "/home/chika";

	home.stateVersion = "23.05"; # Don't change

	programs.home-manager.enable = true;

	news.display = "silent";

}
