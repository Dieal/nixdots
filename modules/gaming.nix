{ pkgs, lib, config, unstable, ... }: {
    home.packages = with pkgs; [
        # [[ GAMING ]]
        lutris
        protonup-qt
        corefonts
        dxvk
        wineWowPackages.staging
        gamescope
        mangohud
        prismlauncher  # MultiMC Fork (Minecraft)

        # Steam Tinker Launch Dependencies
        steamtinkerlaunch
        xdotool
        yad
    ] ++ [
        unstable.protontricks
        unstable.winetricks
    ];
}
