function nixedit
	set nix_dir /etc/nixos
	pushd $nix_dir
	$EDITOR configuration.nix
	if git diff -U0 --exit-code *.nix
		popd && return 0
	end
	echo "Rebuilding NixOS..."
	if not sudo nixos-rebuild switch --flake "$nix_dir"#default
		popd && return 1
	end
	git commit -am (nixos-rebuild list-generations | grep current)
	popd
end
