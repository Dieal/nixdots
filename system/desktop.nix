{ config, pkgs, ... } @inputs :
{

  imports = [ ./shared.nix ];

  networking.hostName = "desktop"; # Define your hostname.

  boot.loader = {
    grub = {
      gfxmodeEfi = "1920x1080";
    };
  };

  # Graphical Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  swapDevices = [ {
	  device = "/var/lib/swapfile";
	  size = 32*1024;
  } ];


  users.groups.dotfiles = {};
  users.groups.gamer = {};
  users.users.brother = {
    group = "users";
    isNormalUser = true;
    description = "Dieal's brother";
    extraGroups = [ "networkmanager" "dotfiles" "gamer" ];
    shell = pkgs.fish;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics.enable = true; # Enable OpenGL
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = true;
    };
  };

  environment.sessionVariables = {
     LIBVA_DRIVER_NAME = "nvidia";
     __GLX_VENDOR_LIBRARY_NAME = "nvidia";
     NVD_BACKEND = "direct";
     GDK_SCALE = "1";
  };

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
}
