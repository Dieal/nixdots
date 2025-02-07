.PHONY: update
update:
	home-manager switch --flake .#dieal

.PHONY: laptop
laptop:
	sudo nixos-rebuild switch --flake .#nixos --impure

.PHONY: desktop
desktop:
	sudo nixos-rebuild switch --flake .#desktop --impure

.PHONY: clean
clean:
	nix-collect-garbage -d
