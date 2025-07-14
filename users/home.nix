{ pkgs, unstable, lib, config, ... } @inputs: 
let
    username = "dieal";
    cfg = config.fonts;
in
{

    imports = [
        ../modules/common.nix
    ];

    # Fixes "Sqlite DB: command-not-found"
    programs.nix-index =
    {
        enable = true;
        enableFishIntegration = true;
    };

    # Update nix cache with:
    # fc-cache -f 
    nixpkgs.config.allowUnfree = true;
    fonts.fontconfig.enable = true;
    home = {

        packages = with pkgs; [

            # ==== [[ DEV ]] ====
            tmux
            kitty
            less
            dbeaver-bin # SQL Client
            tealdeer # TLDR Command (soo useful)
            nix-tree
            filezilla # FTP Client
            ffmpeg
            file
            # android-studio-full # Android development IDE
            unrar
            atool
            gh                  # Github CLI (for authentication)

            # ==== [[ FONTS ]] ====
            # (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
            # fira-code
            nerd-fonts.fira-code
            
            # ==== [[ MISC ]] ====
            foliate # Epub Reader
            jellyfin-media-player
            ungoogled-chromium
            trash-cli
            feishin # Navidrone music player
            vlc
            mpv
            scrcpy # Android screen mirroring with touch and sound
            appimage-run
            pinta # Paint alternative
            rnote # Notes / Drawing app
            feather
            signal-desktop
            stremio
            qbittorrent
            speedcrunch # Binary Calculator
            localsend # Local File Sharing app
            kdePackages.okular
            mupdf
            feh
            thunderbird
            keepassxc
            syncthing
            yazi # Terminal File Manager with Vim Keybindings :)
            discord
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

        # DO NOT TOUCH
        stateVersion = "23.11";
    };
}
