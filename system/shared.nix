{ config, pkgs, ... }: {
  imports =
    [
      /etc/nixos/hardware-configuration.nix
    ];


  # Bootloader
  # If you happen to have systemd-boot installed, remove it (/boot/EFI/BOOT/BOOTX64.EFI)
  # To Install: sudo nixos-rebuild --install-bootloader boot --flake .#nixos --impure
  # https://discourse.nixos.org/t/change-bootloader-to-grub/49947
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      minegrub-theme = {
        enable = true;
        splash = "100% Flakes!";
        background = "background_options/1.8  - [Classic Minecraft].png";
        boot-options-count = 4;
      };
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };


  # ===================
  # [[ Network Setup ]]
  # ===================
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none"; # Disable Internal DNS

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  networking.nameservers = [ "9.9.9.9" "1.1.1.1" ]; # DNS
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enables Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Enable Hyprland
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.sessionVariables = {
    # GDK_BACKEND="x11";
    SDL_VIDEODRIVER="x11";
    CLUTTER_BACKEND="x11";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Uncomment to disable Wayland
  # services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = { # Automatic printer discovery
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };


  hardware = {
    pulseaudio.enable = false;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  users.users.dieal = {
    isNormalUser = true;
    description = "Dieal";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    shell = pkgs.fish;
  };

  users.users.dieal = {
    packages = with pkgs; [
      flatpak
    ];
  };

  security.sudo = {
    extraRules = [{
      commands = [
        { command = "${pkgs.systemd}/bin/systemctl suspend"; options = [ "NOPASSWD" ]; }
        { command = "${pkgs.systemd}/bin/reboot"; options = [ "NOPASSWD" ]; }
        { command = "${pkgs.systemd}/bin/poweroff"; options = [ "NOPASSWD" ];
        }
      ];
    }];
  };

  # Fingerprints Support
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.adb.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Virtualizazion
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["dieal"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = with pkgs; [

      # DEV
      fish
      wget
      curlMinimal
      git
      gcc
      go
      nodejs_22
      python3
      gnumake
      pulsemixer
      pavucontrol

      nix-search-cli
      home-manager
      v4l-utils

      # Compression
      gnutar
      unzip
      gzip
      p7zip-rar
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # ================
  #  [[ SERVICES ]]
  # ================
  # services.openssh.enable = true;

  services.syncthing = {
    enable = true;
    group = "users";
    user = "dieal";
    dataDir = "/home/dieal/Documents";
    configDir = "/home/dieal/.config/syncthing";
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder

  # Open ports in the firewall.
  # 53317: LocalSend
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
