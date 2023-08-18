function nixshell --wraps nix-shell
  if not test -e shell.nix; and not test -e default.nix
    echo '{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [

  ];
}' > shell.nix
    echo 'Initialized shell.nix' >&2
    return 0
  else
    echo 'shell.nix or default.nix already exists' >&2
    return 1
  end
end
