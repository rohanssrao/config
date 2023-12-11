function nixshell
  if not test -e flake.nix;
		echo '{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05"; };
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
				
      ];
			shellHook = ''
				exec fish
			'';
    };
  };
}' > flake.nix
    echo 'Initialized flake' >&2
    return 0
	else;
		nix develop --command $SHELL
	end
end
