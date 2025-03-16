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
            tmux
            kitty
            busybox # Bundle of Unix Utilities
            less
            dbeaver-bin # SQL Client
            tealdeer # TLDR Command
            nix-tree

            # ==== [[ FONTS ]] ====
            (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
            fira-code
            

            # ==== [[ MISC ]] ====
            rnote # Notes / Drawing app
            feather
            signal-desktop
            stremio
            qbittorrent
            speedcrunch # Binary Calculator
            localsend # Local File Sharing app
            okular
            mupdf
            feh
            thunderbird
            keepassxc
            syncthing
            yazi # Terminal File Manager with Vim Keybindings :)
            discord-canary
            telegram-desktop
            libreoffice-qt6-fresh
            sutils # Battery and CPU Monitor
            htop
            dust # du Alternative
            gdu  # Faster alternative to ncdu

            # Music
            cmus # Terminal Player
            picard # MusicBrainz Picard: tool to edit and add public music metadata
            nicotine-plus # Soulseek Client

            # Download and build manga cbz for Kobo
            kcc # Kobo Resolution: 1262x1680
            hakuneko
        ] ++ [
            # Unstable PKGS and other inputs go here
            inputs.zen-browser.packages."x86_64-linux".default
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
