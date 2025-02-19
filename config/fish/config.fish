status is-login; and begin
    # Login shell initialisation
end

status is-interactive; and begin

    # Abbreviations
    abbr --add -- oo 'nvim $OBSIDIAN/obsidian.md'
    abbr --add -- t tmux
    abbr --add -- ta 'tmux a'
    abbr --add -- tat 'tmux a -t'
    abbr --add -- tk 'tmux kill-session -t'
    abbr --add -- tl 'tmux ls'
    abbr --add -- waypaper 'waypaper --folder ~/dotfiles/config/hypr/wallpapers --backend hyprpaper'

    # Aliases
    alias cat bat
    alias ls 'eza -l -g --icons --sort type'

    # [[ Keybindings ]]
    bind \cx accept-autosuggestion
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

end
