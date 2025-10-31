set flake "/etc/nixos"

function edit
  $EDITOR $flake/flake.nix
end

function rebuild
  sudo -v
  run nh os switch $flake $argv; or return
  git -C $flake add -A; or return
  git -C $flake diff-index --quiet HEAD; or git -C $flake commit -q -m "rebuild"
end

function upgrade
  rebuild -u
end

function push
  pushd $flake
  git reset --soft origin/main
  git diff --staged
  git commit && git push
end

function run
  nix run --offline nixpkgs#$argv[1] -- $argv[2..-1]
end

function search
  run nix-search-cli $argv
end

function ,
  if not set -q argv[1]; echo "usage: , <program>" >&2; return 1; end
  if command -q $argv[1]; $argv; return; end
  set package (search --query-string="package_programs:($argv[1])" | awk '{print $1}' | sort -u | fzf -0 --height=20 --reverse --bind "one:accept,alt-j:down,alt-k:up") || return 1
  if test -z "$package"; echo "no providers found for $argv[1]" >&2; return 1; end
  nix shell nixpkgs#$package --command $argv
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
