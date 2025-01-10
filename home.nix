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

            # ==== [[ DEV ]] ====
            gnumake
            tmux
            kitty
            busybox # Bundle of Unix Utilities
            php84
            php84Packages.composer

            # ==== [[ FONTS ]] ====
            (nerdfonts.override { fonts = [ "FiraCode" ]; })
            fira-code

            # ==== [[ MISC ]] ====
            localsend # Local File Sharing app
            okular
            element-desktop # Matrix Client
            keepassxc
            syncthing
            discord-canary
            mupdf
            telegram-desktop
            libreoffice-qt6-fresh

            # Download and build manga cbz for Kobo
            kcc # Kobo Resolution: 1262x1680
            hakuneko
        ] ++ [
            # Unstable PKGS go here
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
