{
  pkgs,
  config,
  hyprland-plugins,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
    ];
  };

  home.packages = with pkgs; [
    # == [ UTILS ] ==
    dunst # Notification daemon
    cliphist # Clipboard Manager
    # overskride # Bluetooth Manager
    kdePackages.bluedevil
    blueman
    networkmanagerapplet # Network Manager Applet
    bemoji # Emoji Picker, support for Rofi
    wtype # Typing Indicator, required for bemoji
    playerctl # Media Player Controller
    brightnessctl # Brightness Controller
    wl-clipboard
    wev # Wayland Event Viewer (for reading keycodes)
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    dex # Autostart stuff in .config/autostart
    swaylock-effects # Lock screen

    # Update .desktop entries
    # update-desktop-database ~/.local/share/applications/
    desktop-file-utils

    # == [ STYLING ] ==
    waybar # Status Bar
    rofi-wayland # App Menu
    nwg-look
    nwg-drawer
    gtk3
    kdePackages.qt6ct

    (pkgs.writeShellScriptBin "telegram-gtk" ''
      export XDG_CURRENT_DESKTOP=Hyprland
      export XDG_SESSION_DESKTOP=Hyprland
      export GTK_USE_PORTAL=1
      exec telegram-desktop "$@"
    '')

    # == [ HYPRLAND UTILITIES ] ==
    hyprpolkitagent # Authentication Daemon
    hyprpaper # Wallpaper Setter
    hyprpicker # Color picker
    hyprshade # Shader manager
    hyprshot # Screenshot Tool
    waypaper # Wallpaper Setter

    grim
    xdg-desktop-portal-wlr
    slurp
  ];

  home.file = {
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/";
    ".config/swaylock".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/swaylock/";
    ".local/share/icons/custom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/cursors/";
  };

  # Fixes QT File Manager opening instead of GTK Nautilus
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
    config.common.default = "hyprland";
  };

  xdg.desktopEntries = {
    okular = {
      name = "Okular (X11)";
      genericName = "Document Viewer";
      comment = "View and annotate documents";
      exec = "env okular %U";
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
  };

  systemd.user.services.random_wallpaper = {
    Unit = {
      Description = "Sets a random wallpaper with waypaper (hyprpaper backend)";
    };

    Service = {
      ExecStart = "/home/dieal/.nix-profile/bin/waypaper --folder ~/dotfiles/config/hypr/wallpapers --backend hyprpaper --random";
      Type = "oneshot";
    };
  };
  systemd.user.timers.random_wallpaper = {
    Timer = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Unit = "random_wallpaper.service";
    };
    Install.WantedBy = ["timers.target"]; # Ensures timer starts at boot
  };
}
