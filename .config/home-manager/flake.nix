{
	description = "Home Manager configuration of chika";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			homeConfigurations."chika" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				# Specify your home configuration modules here, for example,
				# the path to your home.nix.
				modules = [ ./home.nix ];
				# Optionally use extraSpecialArgs
				# to pass through arguments to home.nix
				extraSpecialArgs = {
					inherit self;
				};
			};
			packages.${system}.chikafox = pkgs.stdenv.mkDerivation {
				name = "chikafox";
				src = pkgs.firefox;
				buildPhase = ''
					mkdir $out
					cp -r * $out/
					cp ${builtins.toFile "ffconfig" ''
					// skip 1st line
					try {
						let cmanifest = Cc['@mozilla.org/file/directory_service;1'].getService(Ci.nsIProperties).get('UChrm', Ci.nsIFile);
						cmanifest.append('utils');
						cmanifest.append('chrome.manifest');
						if(cmanifest.exists()){
							Components.manager.QueryInterface(Ci.nsIComponentRegistrar).autoRegister(cmanifest);
							ChromeUtils.importESModule('chrome://userchromejs/content/boot.sys.mjs');
						}
					} catch(ex) {};
					''} $out/lib/firefox/config.js
				'';
			};
		};
}
