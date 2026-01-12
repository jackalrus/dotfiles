{ config, pkgs, ... }:

{
  home.file = {
    ".config/waybar/config.jsonc".text = ''
      {
        "layer": "top",
        "position": "top",
        "height": 36,
        "margin-top": 4,
        "margin-left": 8,
        "margin-right": 8,
        "spacing": 12,
        "output": "DP-2",

        // MacOS-style layout: left workspaces + window, center clock, right system tray
        "modules-left": [
          "hyprland/workspaces"
        ],
        "modules-center": [
          "hyprland/window"
        ],
        "modules-right": [
          "tray",
          "hyprland/language",
          "pulseaudio",
          "custom/external-ip",
          "cpu",
          "memory",
          "clock"
        ],

        "hyprland/workspaces": {
          "format": "{icon}",
          "format-icons": {
            "active": "●",
            "default": "○"
          }
        },

        "hyprland/window": {
          "format": "{title}",
          "max-length": 60,
          "separate-outputs": true
        },

        "hyprland/language": {
          "format": "⌨ {}",
          "format-en": "EN",
          "format-ru": "RU",
          "tooltip": false
        },

        "clock": {
          "format": "{:%a, %d %b  %H:%M}",
        },

        "pulseaudio": {
          "format": "{icon} {volume}%",
          "format-muted": "󰖁",
          "format-icons": {
            "default": [
              "󰕿",
              "󰖀",
              "󰕾"
            ]
          },
          "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
          "scroll-step": 2
        },

        "custom/external-ip": {
          "format": "󰈀  {}",
          "exec": "curl -s --max-time 3 ifconfig.me 2>/dev/null || echo N/A",
          "interval": 30,
          "tooltip": true
        },
        "network": {
          "format-wifi": "  {signalStrength}%",
          "format-ethernet": "",
          "format-disconnected": "󰖪",
          "tooltip": true
        },

        "cpu": {
          "format": "󰻠 {usage}%",
          "tooltip": true
        },

        "memory": {
          "format": "󰍛 {used:0.1f}G",
          "tooltip": true
        },

        "tray": {
          "icon-size": 18,
          "spacing": 10
        }
      }
    '';

    ".config/waybar/style.css".text = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Symbols Nerd Font", system-ui, -apple-system, BlinkMacSystemFont, "SF Pro Text", "Inter", sans-serif;
        font-size: 15px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      #waybar {
        color: #ffffff;
      }

      /* Main bar container */
      .modules-left,
      .modules-center,
      .modules-right {
        background: rgba(20, 20, 20, 0.90);
        border-radius: 10px;
        padding: 6px 12px;
        margin: 0 4px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.35);
      }

      #tray,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #battery,
      #clock,
      #window,
      #workspaces {
        padding: 0 8px;
      }

      #workspaces button {
        color: #bbbbbb;
        background: transparent;
        border-radius: 999px;
        padding: 0 6px;
        margin: 0 2px;
      }

      #workspaces button.active {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.18);
      }

      #workspaces button:hover {
        background: rgba(255, 255, 255, 0.28);
      }

      #window {
        color: #e5e5e5;
      }

      #clock {
        font-weight: 500;
      }

      #language,
      #custom-external-ip,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #battery {
        color: #dddddd;
      }

      #battery.warning {
        color: #f5e3a3;
      }

      #battery.critical {
        color: #ff6b6b;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}
