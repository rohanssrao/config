function run
  nix shell nixpkgs#$argv[1] --command "$argv"
end
