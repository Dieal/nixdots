{ pkgs, lib, config, ... }: {
    home.packages = with pkgs; [
        # [[ GAMING ]]
        lutris
        protonup-qt
        corefonts
        dxvk
        wineWowPackages.staging
        gamescope
        prismlauncher  # MultiMC Fork (Minecraft)
    ];
}
