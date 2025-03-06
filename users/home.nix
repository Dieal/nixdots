let
    username = "dieal";
in
{ pkgs, unstable, ... } @inputs: {

    imports = [
        ../modules/common.nix
    ];

    fonts.fontconfig.enable = true;
    home = {
        packages = with pkgs; [

            # ==== [[ DEV ]] ====
            unrar-free
            tmux
            kitty
            busybox # Bundle of Unix Utilities
            dbeaver-bin # SQL Client
            tealdeer # TLDR Command

            # ==== [[ FONTS ]] ====
            (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
            fira-code
            

            # ==== [[ MISC ]] ====
            stremio
            qbittorrent
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
            discord-canary
            telegram-desktop
            libreoffice-qt6-fresh
            sutils # Battery and CPU Monitor
            htop
            dust # du Alternative
            gdu  # Faster alternative to ncdu

            # Download and build manga cbz for Kobo
            kcc # Kobo Resolution: 1262x1680
            hakuneko
        ] ++ [
            # Unstable PKGS and other inputs go here
            inputs.zen-browser.packages."x86_64-linux".default
            cmus
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
