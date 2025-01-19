.PHONY: update
update:
	home-manager switch --flake .#dieal

.PHONY: switch
switch:
	sudo nixos-rebuild switch --flake .#nixos --impure

.PHONY: clean
clean:
	nix-collect-garbage -d
