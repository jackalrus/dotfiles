{

  description = "Gagaryn flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      main = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
    homeConfigurations = {
      gagaryn = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ( { config, pkgs, ... }: {
            home.file.".config/hypr/hyprland.conf" = {
              source = ./hyprland.conf;
              force = true;
            };
          } )
#          {
#            wayland.windowManager.hyprland = {
#              enable = true;
              # set the flake package
#              package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
#              portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
#            };
#          }
        ];
      };
    };
  };

}
