function edit
  $EDITOR /etc/nixos/configuration.nix
end

function os
  sudo true
  run nh os $argv[1] /etc/nixos $argv[2..-1]; or return
  git -C /etc/nixos add -A; or return
  git -C /etc/nixos diff-index --quiet HEAD; or git -C /etc/nixos commit -q -m "rebuild"
end

function push
  pushd /etc/nixos
  git reset --soft origin/main
  git commit
  git push
end

function run
  if [ $argv[1] = "--unfree" ]
    NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$argv[2] -- $argv[3..-1]
  else
    nix run nixpkgs#$argv[1] -- $argv[2..-1]
  end
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
  end
end
