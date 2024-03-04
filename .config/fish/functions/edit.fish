function edit
  pushd /etc/nixos
  $EDITOR configuration.nix
  if git diff -U0 --exit-code *.nix
    popd && return 0
  end
  popd
end
