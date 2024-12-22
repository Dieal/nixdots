{ pkgs, lib, config, unstable, ... }: {
    home.packages = with pkgs; [
        neovim
        luajitPackages.luarocks
        ripgrep
        wl-clipboard
        alejandra
        fd
        fzf

        # ============================
        # == [[ LANGUAGE SERVERS ]] ==
        # ============================
        python311Packages.jedi-language-server
        lua-language-server
        nixd # Nix Language Server
        phpactor
        tailwindcss-language-server
        vscode-langservers-extracted # HTML and CSS
        emmet-language-server
        vue-language-server
        typescript-language-server
        marksman # Markdown

        /* eslint = {},
        dockerls = {},
        ansiblels = {},
        clangd = {},
        },
          }, */
    ];

    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim/";
    };
}
