let
    username = "dieal";
in
{ pkgs, ... }: {

    imports = [
        ./modules/config/nvim.nix
        ./modules/config/shell.nix
    ];

    home = {
        packages = with pkgs; [
            fish
            eza # Prettier alternative to ls
            gnumake
            neovim
            luajitPackages.luarocks
            python312Packages.jedi-language-server
            flutterPackages-source.v3_26
            ripgrep
            wl-clipboard
            nixd # Nix Language Server
            alejandra
            fd
            fzf
        ];

        inherit username;
        homeDirectory = "/home/${username}";

        keyboard.layout = "it";

        stateVersion = "23.11";
    };

}
