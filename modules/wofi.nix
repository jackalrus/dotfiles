{ config, pkgs, ... }:

{
  home.file = {
    ".config/wofi/config".text = ''
      width=600
      height=400
      location=center
      show=drun
      prompt=Search...
      filter_rate=100
      allow_markup=true
      no_actions=true
      halign=fill
      orientation=vertical
      content_halign=fill
      insensitive=true
      allow_images=true
      image_size=32
      gtk_dark=true
      term=kitty
    '';

    ".config/wofi/style.css".text = ''
      * {
        font-family: "SF Pro Text", "Inter", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
        font-size: 14px;
      }

      window {
        margin: 0px;
        border: none;
        background-color: transparent;
      }

      #input {
        margin: 12px;
        padding: 12px 16px;
        border: none;
        border-radius: 10px;
        background-color: rgba(30, 30, 30, 0.95);
        color: #ffffff;
        font-size: 15px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
      }

      #input:focus {
        background-color: rgba(35, 35, 35, 0.95);
        outline: none;
      }

      #inner-box {
        margin: 0px 12px 12px 12px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 0px;
        border: none;
        background-color: rgba(20, 20, 20, 0.95);
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.45);
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 0px;
        padding: 0px;
        color: #e5e5e5;
      }

      #entry {
        margin: 2px 0px;
        padding: 10px 16px;
        border: none;
        border-radius: 8px;
        background-color: transparent;
        transition: all 0.15s ease;
      }

      #entry:selected {
        background-color: rgba(255, 255, 255, 0.12);
        color: #ffffff;
      }

      #entry:hover {
        background-color: rgba(255, 255, 255, 0.08);
      }

      #entry:selected:hover {
        background-color: rgba(255, 255, 255, 0.16);
      }

      #entry image {
        margin-right: 12px;
        border-radius: 6px;
      }

      #text:selected {
        color: #ffffff;
      }
    '';
  };
}

