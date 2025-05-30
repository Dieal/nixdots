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
        protontricks
        winetricks

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

        # Skyrim
        limo

        # Euro Truck Simulator 2
        # aitrack
        # opentrack
        # droidcam
    ] ++ [
    ];
}
