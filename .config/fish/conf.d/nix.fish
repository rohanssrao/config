set sys_flake "/etc/nixos"

function edit
  $EDITOR $sys_flake/flake.nix
end

function rebuild
  sudo -v
  nix run nixpkgs#nh -- os switch $sys_flake $argv[1..-1]; or return
  git -C $sys_flake add -A; or return
  git -C $sys_flake diff-index --quiet HEAD; or git -C $sys_flake commit -q -m "rebuild"
end

function push
  pushd $sys_flake
  git reset --soft origin/main
  git diff --staged
  git commit && git push
end

function run
  nix run nixpkgs#$argv[1] -- $argv[2..-1]
end

function ,
  if not set -q argv[1]; echo "usage: , <program>" >&2; return 1; end
  set package (nix run nixpkgs#nix-search-cli -- --query-string="package_programs:($argv[1])" | awk '{print $1;}' | fzf -0 --height=20 --reverse) || return 1
  if test -z "$package"; echo "no providers found for $argv[1]" >&2; return 1; end
  nix shell nixpkgs#$package --command $argv
end

function search
  nix run nixpkgs#nix-search-cli -- $argv
end

function shell
  if set -q argv[1]
    nix shell nixpkgs#{$argv}
  else if test -e flake.nix
    nix develop --command $SHELL
  else
    echo \
'{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, ... }: let
    system = "'(nix eval --impure --raw --expr 'builtins.currentSystem')'";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        
      ];
    };
  };
}' > flake.nix
    $EDITOR flake.nix
  end
end
