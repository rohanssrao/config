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
		pv
		spotdl

	];

	home.username = "chika";
	home.homeDirectory = "/home/chika";

	home.stateVersion = "23.11"; # Don't change

	news.display = "silent";

	programs.home-manager.enable = true;

}
