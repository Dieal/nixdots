These are my **personal** NixOS dotfiles. I advice against using them
since they are specific to my workflow, but you can copy them and change to
your own needs

# Overview
- ❄️  Flakes
- 🏠 Home Manager
- 🗂️ Modularized Configurations
- 🖥️ Different configurations for each of my devices
- 🌟 Hyprland
- 💗 Neovim, Kitty and Tmux

# Installation 🖥️
1. Install the system using the GUI installer or following the NixOS guide

2. Install required packages
`nix-shell -p gnumake git`

3. Clone this repository
`git clone https://github.com/Dieal/nixdots.git`

4. `make desktop` or `make laptop`

# Usage
The system can be built executing
`make desktop` or `make laptop`, depending on the device.
If you want to use it for your own device, edit shared.nix
and system/desktop.nix to your specific needs.

To build the user environment using Home Manager, execute
`make home`.

## Import Firefox settings to Zen Browser
Go to about:support and identify Profile Folder. From inside the folder, copy:
- cookies.sqlite and storage.sqlite to remain logged in
- places.sqlite for history

Then identify, just as above, the Zen Browser profile folder and copy
those sqlite files inside it. Now restart the browser, follow the setup
and you're done

## Rescue Mode
- su <your_user>
- cd dotfiles
- make the changes to fix the booting process
- make desktop-boot



# Useful resources
- https://github.com/Evertras/simple-homemanager Flakes and Home Manager setup for beginners
- https://mynixos.com/help/home-manager Find home manager options
