{ config, pkgs, ... } @inputs :
{
  imports = [ ./shared.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
