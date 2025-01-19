{ pkgs, lib, config, unstable, ... }: {
    home.packages = with pkgs; [

        # == [ UTILS ] ==
        dunst # Notification daemon
        cliphist # Clipboard Manager
        hyprshade # Shader manager
        overskride # Bluetooth Manager
        networkmanagerapplet # Network Manager Applet
        udiskie # Automount USB
        bemoji # Emoji Picker, support for Rofi
        wtype # Typing Indicator, required for bemoji
        playerctl # Media Player Controller
        brightnessctl # Brightness Controller
        wl-clipboard

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
        hyprlandPlugins.hyprgrass
        hyprlandPlugins.hyprspace
    ];

    home.file = {
        ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/hypr/";
    };
}
