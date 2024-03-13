# Helper functions for Nix

function edit
  $EDITOR /etc/nixos/configuration.nix
end

function update
  nix flake update --flake /etc/nixos#default && rebuild
end

function run
  nix shell nixpkgs#$argv[1] -c $argv
end

function rebuild
  git -C /etc/nixos add -A
  sudo nixos-rebuild switch --flake /etc/nixos#default; or return
  git -C /etc/nixos commit -m "rebuild"
end

# nix-ld
function python3
  eval LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH (command -v python3) (string escape -- $argv)
end

function shell
  if set -q argv[1]
    nix shell nixpkgs#{$argv}
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
