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
        # texliveMedium # LaTeX Compiler
        tree-sitter

        # ============================
        # == [[ LANGUAGE SERVERS ]] ==
        # ============================
        basedpyright
        ruff
        mypy
        rust-analyzer
        ccls
        jdt-language-server # Java
        # jdk # JDK 21, required by jdt
        lua-language-server
        nixd # Nix Language Server
        phpactor
        tailwindcss-language-server
        vscode-langservers-extracted # HTML and CSS
        emmet-language-server
        typescript
        typescript-language-server
        marksman # Markdown

        # ===============================
        # == [[ DEBUGGING PROTOCOLS ]] ==
        # ===============================
        # //////
    ];

    home.file = {
        ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim/";
    };
}
