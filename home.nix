{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            hello
        ];

        username = "dieal";
        homeDirectory = "/home/dieal";

        stateVersion = "23.11";
    };
}
