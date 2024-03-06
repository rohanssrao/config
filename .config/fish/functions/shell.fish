function shell
  if set -q argv[1]
    NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#{$argv}
  else if test -e flake.nix
    nix develop --command $SHELL
  else
    echo \
'{
inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };
outputs = {nixpkgs, ...}: let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
in {
  devShells.x86_64-linux.default = pkgs.mkShell {
    packages = with pkgs; [
      
    ];
  };
};
}' > flake.nix
    $EDITOR flake.nix
    nix flake update
  end
end
