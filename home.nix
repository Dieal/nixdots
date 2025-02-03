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
            uv # Python Package Manager
            dbeaver-bin # SQL Client
            tealdeer # TLDR Command
            android-studio

            # ==== [[ FONTS ]] ====
            (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
            fira-code
            

            # ==== [[ MISC ]] ====
            speedcrunch # Binary Calculator
            localsend # Local File Sharing app
            okular
            mupdf
            feh
            thunderbird
            element-desktop # Matrix Client
            keepassxc
            syncthing
            yazi # Terminal File Manager with Vim Keybindings :)
            vesktop # Discord Client to screenshare on wayland
            telegram-desktop
            libreoffice-qt6-fresh
            sutils # Battery and CPU Monitor

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
