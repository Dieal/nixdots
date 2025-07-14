{ config, pkgs, ... } :
{
  imports = [ ./shared.nix ];

  # Machine name
  networking.hostName = "laptop"; # Define your hostname.

  # Wireguard
  networking.wireguard.enable = true;
  networking.firewall.allowedUDPPorts = [ 51820 ];

  # Wireguard
  # networking.wireguard.enable = true;
  environment.systemPackages = [ pkgs.wireguard-tools ];

  # Graphical Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  environment.sessionVariables = {
     GDK_SCALE = "1.75";
  };
}
