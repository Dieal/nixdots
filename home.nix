let
    username = "dieal";
in
{ config, lib, pkgs, unstable, ... }: {

    imports = [
        ./modules/gaming.nix
        ./config/nvim.nix
        ./config/shell.nix
    ];

    fonts.fontconfig.enable = true;
    home = {
        packages = with pkgs; [
            gnumake
            flutter
            element-desktop # Matrix Client
            keepassxc
            syncthing
            discord
            mupdf
            telegram-desktop
            kitty
            tmux
            localsend
            libreoffice-qt6-fresh
            nerd-fonts.fira-code
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
