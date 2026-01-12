{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nvidia.nix
      ./modules/greetd.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "main"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gagaryn = {
    isNormalUser = true;
    description = "gagayn";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    code-cursor
    virt-manager
    qemu_kvm
    libvirt
  ];

  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.amnezia-vpn.enable = true;
  programs.firefox.enable = true;

  ### VIRTUAL MASHINE ###
  # --- ядро: загрузить модули KVM (Intel/AMD)
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  # --- включаем libvirtd (qemu/kvm)
  virtualisation.libvirtd.enable = true;
  # используем qemu_kvm (быстрее чем generic qemu)
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
  # включаем программную эмуляцию TPM (нужно для Windows 11)
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  # OVMF (UEFI) — обычно OVMF-образы уже доступны, но если нужен полный пакет:
  # virtualisation.libvirtd.qemu.ovmf.package = pkgs.OVMFFull; # (необязательно)
  # --- GUI/пакеты для управления VM (пользовательский desktop)
  programs.virt-manager.enable = true;  # активирует virt-manager для GUI
  # (опционально) если нужен доступ к USB-редиректу для SPICE:
  virtualisation.spiceUSBRedirection.enable = true;
}
