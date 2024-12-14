let
    username = "dieal";
in
{ lib, pkgs, ... }: {
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
