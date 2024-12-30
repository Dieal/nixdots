let
    username = "dieal";
in
{ config, lib, pkgs, unstable, ... }: {

    imports = [
        ./modules/gaming.nix
        ./config/common.nix
    ];

    fonts.fontconfig.enable = true;
    home = {
        packages = with pkgs; [
            gnumake
            # flutter
            element-desktop # Matrix Client
            keepassxc
            syncthing
            discord-canary
            mupdf
            telegram-desktop
            tmux
            kitty
            localsend
            libreoffice-qt6-fresh
            (nerdfonts.override { fonts = [ "FiraCode" ]; })
            fira-code

            php84
            php84Packages.composer
        ] ++ [
            # Unstable PKGS
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
