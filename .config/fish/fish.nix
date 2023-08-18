{ config, pkgs, ... }:

{

  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./config.fish;
  };

  xdg.configFile."fish/functions" = {
    source = ./functions;
    recursive = true;
  };

  # source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    SHELL = "$(which fish)";
    EDITOR = "$(which lvim)";
    SUDO_EDITOR = "$EDITOR";
    VISUAL = "$EDITOR";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

}
