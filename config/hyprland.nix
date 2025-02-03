{ pkgs, lib, config, unstable, ... }: {
    home.packages = with pkgs; [

        # == [ UTILS ] ==
        dunst # Notification daemon
        cliphist # Clipboard Manager
        overskride # Bluetooth Manager
        networkmanagerapplet # Network Manager Applet
        bemoji # Emoji Picker, support for Rofi
        wtype # Typing Indicator, required for bemoji
        playerctl # Media Player Controller
        brightnessctl # Brightness Controller
        flameshot # Screenshot Tool
        wl-clipboard
        wev # Wayland Event Viewer (for reading keycodes)
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk

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

        # == [ HYPRLAND UTILITIES ] ==
        hyprpolkitagent # Authentication Daemon
        hyprpaper # Wallpaper Setter
        hyprpicker # Color picker
        hyprshade # Shader manager
        hyprshot # Screenshot Tool
        waypaper # Wallpaper Setter
    ];

    home.file = {
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/";
        ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/waybar/";
        ".local/share/applications/custom".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/desktop_entries/";
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
        Install.WantedBy = [ "timers.target" ]; # Ensures timer starts at boot
    };
}
