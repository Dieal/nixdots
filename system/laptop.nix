{ config, pkgs, ... } :
{
  imports = [ ./shared.nix ];

  # If you happen to have systemd-boot installed, remove it (/boot/EFI/BOOT/BOOTX64.EFI)
  # To Install: sudo nixos-rebuild --install-bootloader boot --flake .#nixos --impure
  # https://discourse.nixos.org/t/change-bootloader-to-grub/49947
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  # Machine name
  networking.hostName = "laptop"; # Define your hostname.

  # Graphical Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
     GDK_SCALE = "1.75";
  };
}
