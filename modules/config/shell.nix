{ pkgs, ... }: {

    programs.fish = {
        enable = true;

        plugins = [
            { name = "fzf"; src = pkgs.fishPlugins.fzf; } # Fuzzy Find Files, ecc.
            { name = "z"; src = pkgs.fishPlugins.z; } # Z: easily navigate to previous directories, simply by name (it keeps history)
            { name = "pure"; src = pkgs.fishPlugins.pure; } # Prompt
            { name = "sponge"; src = pkgs.fishPlugins.sponge; } # Keeps Command History Clear from Typos                                
            { name = "puffer"; src = pkgs.fishPlugins.puffer; } # Text Expansions for: !! (last command), .. (../) , !$ (last argument) 
            { name = "pisces"; src = pkgs.fishPlugins.pisces; } # Pair Parenthesis                                                      
            { name = "forgit"; src = pkgs.fishPlugins.forgit; } # Easily Interact with Git and fzf                                      
        ];

        shellAbbrs = {
                oo = "nvim $OBSIDIAN/obsidian.md";
                t = "tmux";                                   # [T]mux
                ta = "tmux a";                                # [T]mux [A]ttach
                tat = "tmux a -t";                            # [T]mux [A]ttach [T]o
                tk = "tmux kill-session -t";                  # [T]mux [K]ill Session
                tl = "tmux ls";                               # [T]mux [L]s
        };

        interactiveShellInit = ''
            # [[ Environment Variables ]]
            set -gx PAGER less
            set -gx EDITOR nvim	
            set -gx SUDO_EDITOR nvim	
            set -gx TERMINAL kitty
            set -gx LUTRIS_SKIP_INIT 1
            set -gx MOZ_USE_XINPUT2 1 # Touchpad Support

            # Paths
            fish_add_path $HOME/.local/bin
            # fish_add_path $HOME/.local/bin/flutter/bin
            # fish_add_path $HOME/.config/composer/vendor/bin


            # --- Abbreviations ---
            alias eza='eza -l -g --icons --sort extension'
            alias ls='eza'

            # Usage: envsource <path/to/env>
            function envsource
              for line in (cat $argv | grep -v '^#' | grep -v '^\s*$') # Ignore blank lines
                set item (string split -m 1 '=' $line)
                set -gx $item[1] $item[2]
              end
            end
            envsource ~/.config/fish/.env # Read and save variables in .env file (such as Obsidian Path)

            # ====================== #
            # ------ Bindings ------ #
            # ====================== #
            bind \cs "source ~/.config/fish/config.fish" # Source Fish Config
            
        '';
    };

}
