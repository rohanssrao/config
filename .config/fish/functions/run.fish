function run
	nix-shell -p $argv[1] --quiet --command "$argv"
end
