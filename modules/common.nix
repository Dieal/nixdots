{ lib, config, ... }: {
    imports = [
        ./nvim.nix
        ./shell.nix
        ./hyprland.nix
        ./gaming.nix
        ./coding.nix
    ];

    home.file = 
        let
            home = "${config.home.homeDirectory}";
            symlink = config.lib.file.mkOutOfStoreSymlink;
        in
        {
        ".config/kitty".source = symlink "${home}/dotfiles/config/kitty/";
        ".config/tmux".source = symlink "${home}/dotfiles/config/tmux/";
        ".config/rofi".source = symlink "${home}/dotfiles/config/rofi/";
        ".config/retroarch/retroarch.cfg".source = symlink "${home}/dotfiles/config/retroarch/retroarch.cfg";
        ".local/share/rofi/themes".source = symlink "${home}/dotfiles/config/rofi/themes/";
    };
}
