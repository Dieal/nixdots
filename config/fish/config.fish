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
    abbr --add -- tp 'trash-put'

    # Aliases
    alias cat bat
    alias ls 'eza -l -g --icons --sort type'
    alias poweroff 'systemctl poweroff'
    alias reboot 'systemctl reboot'
    alias rm 'echo "This is not the command you are looking for."; false'

    # [[ Keybindings ]]
    bind \cx accept-autosuggestion
    bind \cf fzf

    # [[ Environment Variables ]]
    set -gx PAGER less
    set -gx EDITOR nvim
    set -gx SUDO_EDITOR nvim
    set -gx TERMINAL kitty

    # Paths
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.npm-global/bin
    fish_add_path $HOME/.config/composer/vendor/bin
    fish_add_path $HOME/.local/share/flatpak/exports/share
    fish_add_path /usr/share
    fish_add_path /var/lib/flatpak/exports/share

    # cd wrapper
    # function cd --wraps cd
    #     builtin cd $argv[1]
    #
    #     echo $PWD | grep dotfiles
    #     if $status = 0 # Folder is dotfiles
    #         git status | grep -e "Changes not staged for commit" -e ""
    #     end
    #
    # end

end
