{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
  
		fish
		lunarvim
		xclip
		gcc
		eza
		ripgrep
		fd
		bat
		tldr
		fastfetch
		lolcat

	];

	home.username = "chika";
	home.homeDirectory = "/home/chika";

	home.stateVersion = "23.05"; # Don't change

	programs.home-manager.enable = true;

	news.display = "silent";

}
