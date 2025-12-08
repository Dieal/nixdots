{
  pkgs,
  unstable,
  lib,
  config,
  glide,
  ...
} @ inputs: let
  username = "dieal";
  home = "${config.home.homeDirectory}";
  cfg = config.fonts;
  glide = pkgs.callPackage ../packages/glide/package.nix {};
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ../modules/common.nix
  ];

  # Fixes "Sqlite DB: command-not-found"
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );
  };

  # Update nix cache with:
  # fc-cache -f
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs;
      [
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
        gh # Github CLI (for authentication)
        atuin # Shell History
        pet
        tree
        glide
        valent # Implementation of the KDE Connect protocol using GNOME libraries

        # ==== [[ FONTS ]] ====
        # (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
        # fira-code
        nerd-fonts.fira-code

        # ==== [[ MISC ]] ====
        foliate # Epub Reader
        motrix # Download Manager
        tor-browser
        obs-studio
        # jellyfin-media-player
        ungoogled-chromium
        trash-cli
        vlc
        scrcpy # Android screen mirroring with touch and sound
        appimage-run
        pinta # Paint alternative
        rnote # Notes / Drawing app
        feather
        # stremio
        qbittorrent
        speedcrunch # Binary Calculator
        localsend # Local File Sharing app
        kdePackages.okular
        mupdf
        feh
        thunderbird
        keepassxc
        syncthing
        yazi # Terminal File Manager with Vim Keybindings
        discord
        telegram-desktop
        libreoffice-qt6-fresh
        sutils # Battery and CPU Monitor
        htop
        dust # du Alternative (it's fast)
        gdu # Faster alternative to ncdu
        resources # Resources manager

        # Music
        cmus # Terminal Player
        picard # MusicBrainz Picard: tool to edit and add public music metadata
        nicotine-plus # Soulseek Client
        feishin # Navidrone music player

        # Download and build manga cbz for Kobo
        kcc # Kobo Resolution: 1262x1680
        hakuneko
      ]
      ++ [
        # Unstable PKGS and other inputs go here
        # inputs.zen-browser.packages."x86_64-linux".default
        unstable.signal-desktop
      ];

    file = {
      ".local/bin/server".source = symlink "${home}/dotfiles/scripts/server";
    };

    inherit username;
    homeDirectory = "/home/${username}";

    keyboard.layout = "it";

    # DO NOT TOUCH
    stateVersion = "23.11";
  };
}
