{
  config,
  pkgs,
  ...
} @ inputs: {
  imports = [./shared.nix];

  networking.hostName = "desktop"; # Define your hostname.

  boot.loader = {
    grub = {
      gfxmodeEfi = "1920x1080";
    };
  };

  # To check if SSD supports TRIM, run:
  # lsblk --discard
  # and check the "DISC-GRAN" and "DISC-MAX" columns. They should not be "0".
  # If they are "0", your SSD does not support TRIM. https://wiki.archlinux.org/title/Solid_state_drive
  services.fstrim.enable = true; # Enable periodic TRIM for SSD
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Graphical Environment
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  # For Hibernation: change offset and root partition if you reinstall nixos
  powerManagement.enable = true;
  boot.kernelParams = ["nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "resume_offset=18980864"];
  boot.resumeDevice = "/dev/disk/by-uuid/0d937ea9-52c4-4799-833b-c5c67bd7b9a0";

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    '';

  users.groups.dotfiles = {};
  users.groups.gamer = {};
  users.users.brother = {
    group = "users";
    isNormalUser = true;
    description = "Dieal's brother";
    extraGroups = ["networkmanager" "dotfiles" "gamer"];
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
    vulkan-loader
    vulkan-validation-layers
  ];
}
