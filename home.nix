let
    username = "dieal";
in
{ config, lib, pkgs, ... }: {

    imports = [
        ./modules/gaming.nix
        ./modules/config/nvim.nix
        ./modules/config/shell.nix
    ];

    fonts.fontconfig.enable = true;
    home = {
        packages = with pkgs; [
            gnumake
            flutter
            (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
