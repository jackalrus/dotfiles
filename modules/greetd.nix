{ config, pkgs, ... }:

{
  # Hyprland window manager
  programs.hyprland = {
    enable = true;
  };

  # ReGreet login manager configuration
  programs.regreet = {
    enable = true;
    cursorTheme.name = "Bibata-Modern-Classic";
    settings = {
      GTK.application_prefer_dark_theme = true;
      background.path = "/etc/regreet/bg.jpg";
      background.fit = "Contain";
      appearance.greeting_msg = "Good Luck!";
    };
    extraCss = ''
#      window { background-color: "#cccccc"; }
#      box { background-color: blue; }
#      label { color: "#cccccc"; }
    '';
  };

  # Environment files for regreet
  environment.etc = {
    "regreet/bg.jpg" = {
      source = ../bg.jpg;
      mode = "0644";
    };
    "greetd/hyprland.conf" = {
      source = ../hyprland-login.conf;
    };
    ## Добавьте это для пользовательских сессий:
    #"greetd/environments" = {
    #  text = "Hyprland:hyprland\n";
    #  mode = "0644";
    #};
  };

  # GreetD service configuration
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "hyprland -c /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };

  # Required packages for login
  environment.systemPackages = with pkgs; [
    regreet
    bibata-cursors
  ];
}

