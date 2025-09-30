{
  pkgs,
  lib,
  config,
  unstable,
  ...
}: let
  retroarchWithCores = unstable.retroarch.withCores (cores:
    with cores; [
      desmume
      melonds
    ]);
in {
  home.packages = with pkgs;
    [
      # [[ GAMING ]]
      protontricks
      winetricks

      lutris
      heroic
      protonup-qt
      corefonts
      dxvk
      wineWowPackages.staging
      mangohud
      prismlauncher # MultiMC Fork (Minecraft)
      # retroarchWithCores

      # Steam Tinker Launch Dependencies
      steamtinkerlaunch
      xdotool
      yad

      # Euro Truck Simulator 2
      # aitrack
      # opentrack
      # droidcam
    ]
    ++ [
      unstable.osu-lazer-bin
    ];
}
