{ config, pkgs, ... } :
{
  imports = [ ./shared.nix ];

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
