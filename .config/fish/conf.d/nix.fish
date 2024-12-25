function edit
  $EDITOR /etc/nixos/flake.nix
end

function os
  sudo -v
  run nh os $argv[1] /etc/nixos $argv[2..-1]; or return
  git -C /etc/nixos add -A; or return
  git -C /etc/nixos diff-index --quiet HEAD; or git -C /etc/nixos commit -q -m "rebuild"
end

function rebuild
  os switch $argv
end

function push
  pushd /etc/nixos
  git reset --soft origin/main
  git diff --staged
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

function ,
  set package (run nix-search-cli -p $argv[1] | awk 'NR==1{print $1;}')
  echo "[Using package $package]" >&2
  nix shell nixpkgs#$package --command $argv
end

function search
  run nix-search-cli $argv
end

function shell
  if set -q argv[1]
    if [ $argv[1] = "--unfree" ]
      NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs#$argv[2..-1]
    else
      nix shell nixpkgs#{$argv}
    end
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
