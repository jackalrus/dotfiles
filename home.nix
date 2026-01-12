{ config, pkgs, ... }:

{
  imports = [
    ./modules/waybar.nix
    ./modules/wofi.nix
    ./modules/hyprlock.nix
    ./modules/hypridle.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gagaryn";
  home.homeDirectory = "/home/gagaryn";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.kitty
    pkgs.wofi
    pkgs.gh  # GitHub CLI
    pkgs.telegram-desktop
    pkgs.nemo-with-extensions
    pkgs.waybar
    pkgs.jq
    #pkgs.code-cursor
    pkgs.noto-fonts
    pkgs.noto-fonts-color-emoji
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "jackalrus";
      user.email = "jackal.rus@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    ll = "ls -al";
    ".." = "cd ..";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


}
