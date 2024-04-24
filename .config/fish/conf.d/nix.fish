function edit
  $EDITOR /etc/nixos/configuration.nix
end

function update
  pushd /etc/nixos; sudo nix flake update && rebuild; popd
end

function rebuild
  pushd /etc/nixos
  git add -A
  set old_gen (readlink -f /nix/var/nix/profiles/system)
  sudo nixos-rebuild switch --flake /etc/nixos#default; or return
  set new_gen (readlink -f /nix/var/nix/profiles/system)
  if [ $new_gen != $old_gen ]; and command -q nvd; nvd diff $old_gen $new_gen; end
  git diff-index --quiet HEAD; or git commit -q -m "rebuild"
  popd
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
