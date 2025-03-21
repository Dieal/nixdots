{ pkgs, lib, config, unstable, ... }: 

let
retroarchWithCores = (unstable.retroarch.withCores (cores: with cores; [
      desmume
      melonds
]));
in
{
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
        retroarchWithCores

        # Steam Tinker Launch Dependencies
        steamtinkerlaunch
        xdotool
        yad
    ] ++ [
        unstable.protontricks
        unstable.winetricks
    ];
}
