{
  pkgs,
  config,
  hyprland-plugins,
  unstable,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [];
  };

  home.packages = with pkgs; [
    # == [ UTILS ] ==
    dunst # Notification daemon
    cliphist # Clipboard Manager
    overskride # Bluetooth Manager
    # kdePackages.bluedevil
    # blueman
    networkmanagerapplet # Network Manager Applet
    bemoji # Emoji Picker, support for Rofi
    wtype # Typing Indicator, required for bemoji
    playerctl # Media Player Controller
    brightnessctl # Brightness Controller
    wl-clipboard
    wev # Wayland Event Viewer (for reading keycodes)
    dex # Autostart stuff in .config/autostart
    swaylock-effects # Lock screen
    swaynotificationcenter
    libnotify # Notify Send

    # Update .desktop entries
    # update-desktop-database ~/.local/share/applications/
    desktop-file-utils

    # == [ STYLING ] ==
    waybar # Status Bar
    rofi # App Menu
    nwg-look
    nwg-drawer
    gtk3
    fastfetch
    matugen # Generate colorscheme  from  image

    (pkgs.writeShellScriptBin "telegram-gtk" ''
      export XDG_CURRENT_DESKTOP=Hyprland
      export XDG_SESSION_DESKTOP=Hyprland
      export GTK_USE_PORTAL=1
      exec telegram-desktop "$@"
    '')

    # == [ HYPRLAND UTILITIES ] ==
    hyprpolkitagent # Authentication Daemon
    # hyprpaper # Wallpaper Setter
    swww # Wallpaper Backend
    hyprpicker # Color picker
    hyprsunset # Shader manager
    hyprshot # Screenshot Tool
    waypaper # Wallpaper Setter

    grim
    slurp
  ] ++ [
    unstable.vicinae # Launcher
  ];

  # Fixes QT File Manager opening instead of GTK Nautilus
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common = {
      "org.freedesktop.impl.portal.FileChooser" = "gtk";

      # Use the Hyprland backend for screen sharing
      "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
      "org.freedesktop.impl.portal.Screenshot" = "hyprland";
    };
  };

  home.file = {
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/";
    ".config/swaylock".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/swaylock/";
    ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fastfetch/";
    ".config/matugen".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/matugen/";
    ".local/share/icons/custom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/cursors/";
    /*
       ".config/autostart/noisetorch.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Enable Noisetorch
        Comment=Enables noisetorch's virtual microphone
        Exec=noisetorch -i
        StartupNotify=false
        Terminal=false
    '';
    */
  };

  xdg.desktopEntries = {
    okular = {
      name = "Okular (X11)";
      genericName = "Document Viewer";
      comment = "View and annotate documents";
      exec = "env QT_QPA_PLATFORM=xcb okular %U";
      icon = "okular";
      terminal = false;
      categories = ["Qt" "KDE" "Viewer" "Office"];
      startupNotify = true;
    };

    rnote = {
      name = "rnote";
      genericName = "Notetaking App";
      exec = "env -u WAYLAND_DISPLAY rnote";
      icon = "rnote";
      terminal = false;
      startupNotify = true;
    };

    glide-browser = {
      name = "glide";
      genericName = "Browser App";
      exec = "glide";
      icon = "glide";
      terminal = false;
      startupNotify = true;
    };
  };

  /* systemd.user.services.random_wallpaper = {
    Unit = {
      Description = "Sets a random wallpaper with waypaper (hyprpaper backend)";
    };

    Service = {
      ExecStart = "/home/dieal/.nix-profile/bin/waypaper --folder ~/dotfiles/config/hypr/wallpapers --backend hyprpaper --random";
      Type = "oneshot";
    };
  }; */
  systemd.user.timers.random_wallpaper = {
    Timer = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Unit = "random_wallpaper.service";
    };
    Install.WantedBy = ["timers.target"]; # Ensures timer starts at boot
  };
}
