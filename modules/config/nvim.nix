{ pkgs, lib, ... }: {

    home.xdg.configFile = {
        "nvim".source = ./nvim;
    };

};
