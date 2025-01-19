{ pkgs, lib, config, unstable, ... }: {
    home.packages = with pkgs; [
        neovim
        luajitPackages.luarocks
        ripgrep
        wl-clipboard
        alejandra
        fd
        bat
        chafa
        fzf
        zathura # PDF Viewer for Latex
        texliveMedium # LaTeX Compiler
        tree-sitter

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
        typescript
        typescript-language-server
        marksman # Markdown
        hyprls # Hyprland Language Server

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
