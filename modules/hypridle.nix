{ config, pkgs, ... }:

{
  # Добавляем hypridle в пакеты
  home.packages = [
    pkgs.hypridle
  ];

  # Декларативная конфигурация hypridle
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock       # запускаем hyprlock только если он еще не запущен
        before_sleep_cmd = loginctl lock-session    # блокировка перед suspend
        after_sleep_cmd = hyprctl dispatch dpms on  # включаем мониторы после suspend
    }

    listener {
        timeout = 300                                # 5 минут
        on-timeout = loginctl lock-session          # блокируем сессию
    }

    listener {
        timeout = 600                                # 10 минут
        on-timeout = hyprctl dispatch dpms off      # выключаем мониторы
        on-resume = hyprctl dispatch dpms on        # включаем мониторы по движению мыши
    }
  '';
}

