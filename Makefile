.PHONY: update
update:
	home-manager switch --flake .#dieal

.PHONY: clean
clean:
	nix-collect-garbage -d
