function rebuild
  echo "Rebuilding NixOS..."
  if not sudo nixos-rebuild switch --flake /etc/nixos#default
    return 1
  end
  pushd /etc/nixos
  git commit -am (nixos-rebuild list-generations | grep current)
  popd
end
