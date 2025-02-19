{ pkgs, config, ... }: {

    home.packages = with pkgs.fishPlugins; [
        fzf # Keybindings for fzf
        z # Z: easily navigate to previous directories, simply by name (it keeps history)
        sponge # Keeps Command History Clear from Typos
        puffer # Text Expansions for: !! (last command), .. (../) , !$ (last argument)
        # # pisces  # Pair Parenthesis
        # forgit # Easily interact with Git and fzf
    ] ++ [
        pkgs.bash
        pkgs.fd # Alternative to find
        pkgs.fzf # Fuzzy Finder
        pkgs.ripgrep
        pkgs.eza # Prettier alternative to ls
        pkgs.bat # Alternative to cat (syntax highlighting and git integration)
    ];

    home.file = {
        ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/fish/";
    };
}
