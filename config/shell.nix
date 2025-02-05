{ pkgs, ... }: {

    home.packages = with pkgs.fishPlugins; [
        fzf # Keybindings for fzf
        z # Z: easily navigate to previous directories, simply by name (it keeps history)
        sponge # Keeps Command History Clear from Typos
        puffer # Text Expansions for: !! (last command), .. (../) , !$ (last argument)
        pisces  # Pair Parenthesis
        forgit # Easily interact with Git and fzf
        pure # Prompt
    ] ++ [
        pkgs.fish
        pkgs.bash
        pkgs.fd # Alternative to find
        pkgs.fzf # Fuzzy Finder
        pkgs.ripgrep
        pkgs.eza # Prettier alternative to ls
        pkgs.bat # Alternative to cat (syntax highlighting and git integration)
    ];

    programs.fish = {
        enable = true;

        shellAbbrs = {
            oo = "nvim $OBSIDIAN/obsidian.md";
            t = "tmux";                                   # [T]mux
            ta = "tmux a";                                # [T]mux [A]ttach
            tat = "tmux a -t";                            # [T]mux [A]ttach [T]o
            tk = "tmux kill-session -t";                  # [T]mux [K]ill Session
            tl = "tmux ls";                               # [T]mux [L]s
        };

       shellAliases = {
            ls = "eza -l -g --icons --sort type";
            cat = "bat";
        };

        interactiveShellInit = ''

            # [[ Keybindings ]]
            bind \cd accept-autosuggestion
            bind \cf fzf

            # [[ Environment Variables ]]
            set -gx PAGER less
            set -gx EDITOR nvim	
            set -gx SUDO_EDITOR nvim	
            set -gx TERMINAL kitty
            set -gx LUTRIS_SKIP_INIT 1
            set -gx MOZ_USE_XINPUT2 1 # Touchpad Support

            # Paths
            fish_add_path $HOME/.local/bin
            fish_add_path $HOME/.npm-global/bin
            fish_add_path $HOME/.config/composer/vendor/bin
            fish_add_path $HOME/.local/share/flatpak/exports/share
            fish_add_path /usr/share
            fish_add_path /var/lib/flatpak/exports/share
            # fish_add_path $HOME/.local/bin/flutter/bin

            # # Usage: envsource <path/to/env>
            # function envsource
            #   for line in (cat $argv | grep -v '^#' | grep -v '^\s*$') # Ignore blank lines
            #     set item (string split -m 1 '=' $line)
            #     set -gx $item[1] $item[2]
            #   end
            # end
            # envsource ~/.config/fish/.env # Read and save variables in .env file (such as Obsidian Path)

            # ====================== #
            # ------ Bindings ------ #
            # ====================== #
            bind \cs "source ~/.config/fish/config.fish" # Source Fish Config
            
        '';
    };
}
