let
    username = "brother";
in
{ pkgs, ... } @inputs: {

    imports = [
        ../modules/gaming.nix
        ../modules/hyprland.nix
    ];

    fonts.fontconfig.enable = true;
    home = {
        packages = with pkgs; [

            # ==== [[ DEV ]] ====
            unrar-free
            kitty
            tealdeer # TLDR Command

            # ==== [[ FONTS ]] ====
            (nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
            fira-code
            

            # ==== [[ MISC ]] ====
            qbittorrent
            localsend # Local File Sharing app
            mupdf
            feh
            keepassxc
            discord
            telegram-desktop
            sutils # Battery and CPU Monitor
            htop
            dust # du Alternative
            gdu  # Faster alternative to ncdu
        ] ++ [
            # Unstable PKGS go here
            inputs.zen-browser.packages."x86_64-linux".default
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
