{ pkgs, lib, config, ... }: {
    home.packages = with pkgs; [
        # [[ GAMING ]]
        lutris
        lutris-unwrapped
        protonup-qt
        corefonts
        dxvk
        wineWowPackages.wayland
    ];
}
