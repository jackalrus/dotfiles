{ config, pkgs, ... }:

{
  # KVM kernel modules for Intel/AMD processors
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];

  # Libvirtd configuration (QEMU/KVM)
  virtualisation.libvirtd = {
    enable = true;
    # Use qemu_kvm (faster than generic qemu)
    qemu.package = pkgs.qemu_kvm;
    # Enable software TPM emulation (required for Windows 11)
    qemu.swtpm.enable = true;
    # OVMF (UEFI) — usually OVMF images are already available
    # Uncomment if you need the full package:
    # qemu.ovmf.package = pkgs.OVMFFull;
  };

  # Virt-manager GUI for managing VMs
  programs.virt-manager.enable = true;

  # USB redirection for SPICE (optional)
  virtualisation.spiceUSBRedirection.enable = true;

  # Required packages for virtualization
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
    libvirt
  ];
}

