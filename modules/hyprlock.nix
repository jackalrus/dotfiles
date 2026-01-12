{ config, pkgs, ... }:

{
  # Добавляем hyprlock в пакеты
  home.packages = [
    pkgs.hyprlock
  ];

  # Декларативная конфигурация hyprlock
  home.file.".config/hypr/hyprlock.conf".text = ''
    general {
        grace = 1
        hide_cursor = true
        ignore_empty_input = true
    }

    background {
        monitor =
        path = /home/gagaryn/.dotfiles/bg.jpg
        blur_passes = 3
        blur_size = 7
        contrast = 0.8916
        brightness = 0.8172
        vibrancy = 0.1696
        vibrancy_darkness = 0.0
    }

    input-field {
        monitor =
        size = 300, 50
        outline_thickness = 3
        dots_size = 0.26
        dots_spacing = 0.15
        dots_center = true
        outer_color = rgb(33ccff)
        inner_color = rgb(1a1a1a)
        font_color = rgb(ffffff)
        fade_on_empty = false
        placeholder_text = <i>Введите пароль...</i>
        hide_input = false
        position = 0, -120
        halign = center
        valign = center
    }

    label {
        monitor =
        text = cmd[update:1000] echo "$(date +"%H:%M:%S")"
        color = rgb(ffffff)
        font_size = 90
        font_family = JetBrainsMono Nerd Font
        position = 0, 200
        halign = center
        valign = center
    }

    label {
        monitor =
        text = cmd[update:18000000] echo "$(date +"%A, %d %B")"
        color = rgb(ffffff)
        font_size = 24
        font_family = JetBrainsMono Nerd Font
        position = 0, 100
        halign = center
        valign = center
    }

    label {
        monitor =
        text = $USER
        color = rgb(ffffff)
        font_size = 18
        font_family = JetBrainsMono Nerd Font
        position = 0, -50
        halign = center
        valign = center
    }
  '';
}

