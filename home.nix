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
            element-desktop # Matrix Client
            keepassxc
            syncthing
            discord-canary
            mupdf
            telegram-desktop
            tmux
            kitty
            localsend # Local File Sharing app
            libreoffice-qt6-fresh
            (nerdfonts.override { fonts = [ "FiraCode" ]; })
            fira-code
            smile # Emoji Picker

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
