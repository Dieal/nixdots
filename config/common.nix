{ lib, config, ... }: {
    imports = [
        ./nvim.nix
        ./shell.nix
        ./hyprland.nix
    ];

    home.file = 
        let
            home = "${config.home.homeDirectory}";
            symlink = config.lib.file.mkOutOfStoreSymlink;
        in
        {
        ".config/kitty".source = symlink "${home}/dotfiles/config/kitty/";
        ".config/tmux".source = symlink "${home}/dotfiles/config/tmux/";
    };
}
