.PHONY: home
home:
	home-manager switch --flake .#dieal

.PHONY: brother
brother:
	home-manager switch --flake .#brother

# export NIXOS_INSTALL_BOOTLOADER=1 when installing bootloader
.PHONY: laptop
laptop:
	sudo nixos-rebuild switch --flake .#nixos --impure

.PHONY: laptop-boot
laptop-boot:
	sudo nixos-rebuild boot --flake .#nixos --impure

.PHONY: desktop-boot
desktop-boot:
	sudo nixos-rebuild boot --flake .#desktop --impure

.PHONY: desktop
desktop:
	sudo nixos-rebuild switch --flake .#desktop --impure

.PHONY: clean
clean:
	nix-collect-garbage -d
