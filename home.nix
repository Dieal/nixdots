let
    username = "dieal";
in
{ lib, pkgs, ... }: {

    imports = [
        ./modules/config/fish
        ./modules/config/nvim
    ];

    home = {
        packages = with pkgs; [
            fish
            eza # Prettier alternative to ls
            gnumake
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };
}
