{ pkgs, lib, config, ... }: {
    home.packages = with pkgs; [
        neovim
        luajitPackages.luarocks
        lua-language-server
        ripgrep
        wl-clipboard
        nixd # Nix Language Server
        alejandra
        fd
        fzf

        # == [[ LANGUAGE SERVERS ]] ==
        python311Packages.jedi-language-server
    ];

    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/coding/flakes/home-manager/modules/config/nvim/";
}
