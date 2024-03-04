function run
  NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#$argv[1] --impure --command "$argv"
end
