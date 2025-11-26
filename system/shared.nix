{
  config,
  pkgs,
  ...
}: {
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                              SYSTEM CORE                                ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ NixOS Configuration ──────────────────────────────────────────────────┐
  # │ This value determines the NixOS release from which the default         │
  # │ settings for stateful data were taken. Don't change after install.    │
  # └────────────────────────────────────────────────────────────────────────┘
  system.stateVersion = "24.05";

  # ┌─ Nix Package Manager Settings ─────────────────────────────────────────┐
  # │ Enable experimental features like flakes and the new nix command       │
  # │ Allow proprietary software installation                                │
  # └────────────────────────────────────────────────────────────────────────┘
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                               BOOT SYSTEM                               ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Bootloader Configuration ──────────────────────────────────────────────┐
  # │ Uses GRUB with Minecraft theme instead of systemd-boot                 │
  # │ If systemd-boot is installed, remove /boot/EFI/BOOT/BOOTX64.EFI        │
  # │ Install with: sudo nixos-rebuild --install-bootloader boot --flake .#nixos --impure │
  # └────────────────────────────────────────────────────────────────────────┘
  boot = {
    loader = {
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
        useOSProber = true; # Detect other operating systems
      };
      efi.canTouchEfiVariables = true;
    };

    # ┌─ Filesystem & Kernel Support ───────────────────────────────────────┐
    # │ NTFS: Support for Windows filesystems                               │
    # │ v4l2loopback: Virtual camera support for OBS, video conferencing   │
    # └──────────────────────────────────────────────────────────────────────┘
    supportedFilesystems = ["ntfs"];
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    kernelModules = ["v4l2loopback"];
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                           SYSTEM LOCALIZATION                           ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Time & Region Settings ────────────────────────────────────────────────┐
  # │ System timezone and locale configuration for Italy/Italian users       │
  # └────────────────────────────────────────────────────────────────────────┘
  time.timeZone = "Europe/Rome";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  console.keyMap = "it2"; # Italian keyboard layout for console

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                              NETWORKING                                  ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  services.resolved = {
    enable = true;
    fallbackDns = ["9.9.9.9" "1.1.1.1" "1.0.0.1"];
  };

  networking = {
    # ┌─ Network Management ─────────────────────────────────────────────────┐
    # │ NetworkManager handles Wi-Fi, Ethernet, VPN connections             │
    # │ DNS is managed manually instead of using internal resolver          │
    # └──────────────────────────────────────────────────────────────────────┘
    networkmanager = {
      enable = true;
      dns = "systemd-resolved"; # Disable internal DNS management
    };

    # Disable conflicting DHCP services when using NetworkManager
    # useDHCP = true;
    # dhcpcd.enable = true;

    # ┌─ DNS Configuration ──────────────────────────────────────────────────┐
    # │ 9.9.9.9: Quad9 - Security-focused DNS with malware blocking        │
    # │ 1.1.1.1: Cloudflare - Fast, privacy-focused DNS                    │
    # └──────────────────────────────────────────────────────────────────────┘
    nameservers = ["9.9.9.9" "1.1.1.1"];

    # ┌─ Local Network Services ─────────────────────────────────────────────┐
    # │ Custom hostnames for local server services (192.168.1.69)           │
    # │ Allows accessing services via user-friendly names                   │
    # └──────────────────────────────────────────────────────────────────────┘
    extraHosts = ''
      192.168.1.69 dashy.local       # Dashboard service
      192.168.1.69 immich.local      # Image Gallery
      192.168.1.69 calibre.local      
      192.168.1.69 pihole.local      # Pihole DNS
      192.168.1.69 radiscale.local   # Radiscale
      192.168.1.69 planka.local      # Project management
      192.168.1.69 links.local       # Bookmark manager
      192.168.1.69 music.local       # Music streaming
      192.168.1.69 streaming.local   # Video streaming
      192.168.1.69 lidarr.local      # Music collection manager
      192.168.1.69 sonarr.local      # TV show manager
      192.168.1.69 radarr.local      # Movie manager
      192.168.1.69 memos.local       # Note-taking app
      192.168.1.69 qbittorrent.local # Torrent client
      192.168.1.69 npm.local         # Nginx Proxy Manager
      192.168.1.69 audiobooks.local  # Audiobook server
      192.168.1.69 seafile.local     # File synchronization
      192.168.1.69 jellyseer.local   # Request media
      192.168.1.69 vault.dieal.me
    '';

    # ┌─ Firewall Rules ─────────────────────────────────────────────────────┐
    # │ Port 53317: LocalSend file sharing application                      │
    # │ Port 22000 / 21027: Syncthing
    # └──────────────────────────────────────────────────────────────────────┘
    firewall = rec {
      allowedTCPPorts = [
        53317
        22000
      ];
      allowedUDPPorts = [53317 21027];
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                           DESKTOP ENVIRONMENT                           ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Display Server & Desktop ──────────────────────────────────────────────┐
  # │ GNOME desktop environment with GDM login manager                       │
  # │ Wayland is enabled by default (comment out wayland = false)            │
  # └────────────────────────────────────────────────────────────────────────┘
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # displayManager.gdm.wayland = false; # Uncomment to force X11
  };

  services.libinput.enable = true; # Touchpad support for laptops

  # ┌─ Environment Variables ──────────────────────────────────────────────────┐
  # │ Configure application backends and enable Wayland support              │
  # │ Commented variables are for forcing X11 if Wayland causes issues       │
  # └────────────────────────────────────────────────────────────────────────┘
  environment.sessionVariables = {
    # GDK_BACKEND = "x11";           # Force GTK apps to use X11
    SDL_VIDEODRIVER = "wayland"; # Force SDL games to use X11
    CLUTTER_BACKEND = "x11"; # Force Clutter apps to use X11
    MOZ_ENABLE_WAYLAND = "1"; # Enable Wayland for Firefox
    JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                              HARDWARE                                   ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Audio System ───────────────────────────────────────────────────────────┐
  # │ PipeWire: Modern audio server replacing PulseAudio                     │
  # │ Provides better latency and compatibility with professional audio      │
  # │ rtkit: Real-time scheduling for audio processes                        │
  # └────────────────────────────────────────────────────────────────────────┘
  hardware.opentabletdriver.enable = true;
  services.pulseaudio.enable = false; # Disabled in favor of PipeWire
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true; # Support for 32-bit applications
    };
    pulse.enable = true; # PulseAudio compatibility layer
    jack.enable = true; # JACK compatibility for pro audio
  };

  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };

  # ┌─ Printing System ────────────────────────────────────────────────────────┐
  # │ CUPS printing with automatic printer discovery via Avahi/mDNS          │
  # │ Stateless printing: doesn't save printer state between reboots         │
  # └────────────────────────────────────────────────────────────────────────┘
  services.printing = {
    enable = true;
    stateless = true; # Don't persist printer configuration
    drivers = with pkgs; [
      gutenprint
      brlaser
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true; # Enable .local domain resolution
    openFirewall = true; # Allow mDNS traffic through firewall
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                           USER MANAGEMENT                               ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ User Account Configuration ─────────────────────────────────────────────┐
  # │ Main user 'dieal' with administrative privileges and development tools  │
  # │ Groups: wheel (sudo), networkmanager, adbusers, libvirtd (VMs)         │
  # └────────────────────────────────────────────────────────────────────────┘
  users.users.dieal = {
    isNormalUser = true;
    description = "Dieal";
    extraGroups = ["networkmanager" "wheel" "adbusers" "libvirtd"];
    shell = pkgs.fish; # Fish shell as default
    packages = with pkgs; [
      flatpak # Universal package manager
    ];
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                            VIRTUALIZATION                               ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Virtual Machine Management ─────────────────────────────────────────────┐
  # │ libvirt/QEMU: Full system virtualization                               │
  # │ virt-manager: GUI for managing VMs                                     │
  # │ SPICE: Enhanced remote access to VMs                                   │
  # └────────────────────────────────────────────────────────────────────────┘
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["dieal"];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true; # USB passthrough to VMs

    # ┌─ Container Platform ─────────────────────────────────────────────────┐
    # │ Docker with rootless mode for improved security                     │
    # │ setSocketVariable: Automatically set DOCKER_HOST                    │
    # └──────────────────────────────────────────────────────────────────────┘
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                               PROGRAMS                                  ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
        gcc.libc
        glibc
        libgcc
    ];
  };

  programs = {
    # ┌─ Essential Applications ─────────────────────────────────────────────┐
    firefox.enable = true; # Web browser
    fish.enable = true; # Modern shell with autocompletion
    noisetorch.enable = true; # Real-time noise suppression
    adb.enable = true; # Android Debug Bridge
    wireshark.enable = true;
    obs-studio.enableVirtualCamera = true;
    # kdeconnect.enable = true;

    # ┌─ Gaming Platform ────────────────────────────────────────────────────┐
    # │ Steam: Game platform with Proton for Windows game compatibility     │
    # │ GameScope: Wayland compositor optimized for gaming                  │
    # │ GameMode: Optimizes system performance during gaming                │
    # └──────────────────────────────────────────────────────────────────────┘
    steam = {
      enable = true;
      gamescopeSession.enable = true; # Dedicated gaming session
    };
    gamemode.enable = true;
    gamescope.enable = true;
  };

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                               SERVICES                                  ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  services = {
    # ┌─ VPN Service ────────────────────────────────────────────────────────┐
    # │ Mullvad: Privacy-focused VPN provider                               │
    # └──────────────────────────────────────────────────────────────────────┘
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    input-remapper.enable = true;

    # ┌─ File Synchronization ───────────────────────────────────────────────┐
    # │ Syncthing: Decentralized file sync between devices                  │
    # │ Runs as user 'dieal' with data in ~/Documents                       │
    # └──────────────────────────────────────────────────────────────────────┘
    syncthing = {
      enable = true;
      group = "users";
      user = "dieal";
      dataDir = "/home/dieal/Documents";
      configDir = "/home/dieal/.config/syncthing";
    };
  };

  # Prevent Syncthing from creating default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                            SYSTEM PACKAGES                              ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  environment.systemPackages = with pkgs; [
    # ┌─ Development Environment ────────────────────────────────────────────┐
    fish # Modern shell
    git # Version control
    gcc # C/C++ compiler
    go # Go programming language
    nodejs_22 # JavaScript runtime
    python3 # Python interpreter
    gnumake # Build automation tool
    openssl
    lm_sensors # Temperature

    # ┌─ System Utilities ───────────────────────────────────────────────────┐
    wget # File downloader
    curlMinimal # HTTP client (minimal version)
    v4l-utils # Video4Linux utilities for camera management

    # ┌─ Audio Control Tools ────────────────────────────────────────────────┐
    pulsemixer # Terminal-based audio mixer
    pavucontrol # GUI audio control panel

    # ┌─ Nix Ecosystem Tools ────────────────────────────────────────────────┐
    any-nix-shell # Fish shell integration for nix-shell
    nix-search-cli # Command-line package search
    home-manager # User environment management

    # ┌─ Archive & Compression ──────────────────────────────────────────────┐
    gnutar # TAR archiver
    unzip # ZIP extractor
    gzip # GZIP compression
    p7zip-rar #
  ];

  # ╔══════════════════════════════════════════════════════════════════════════╗
  # ║                               SECURITY                                  ║
  # ╚══════════════════════════════════════════════════════════════════════════╝

  # ┌─ Biometric Authentication (Disabled) ───────────────────────────────────┐
  # │ Fingerprint support for compatible hardware                            │
  # │ Uncomment and configure for your specific fingerprint reader           │
  # └────────────────────────────────────────────────────────────────────────┘

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   tod = {
  #     enable = true;
  #     driver = pkgs.libfprint-2-tod1-vfs0090; # Replace with your driver
  #   };
  # };
}
