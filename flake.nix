# Every nix flake evaluates to an expression. In this case it evaluates to an ATTRIBUTE SET
{ 
    description = "Home Manager"; # Optional

    inputs = { 
        # I could name these as I liked.
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        minegrub-theme.url = "github:Lxtharia/minegrub-theme";
        android-nixpkgs = {
            url = "github:tadfisher/android-nixpkgs";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # The dot notation is a shortcut. I could write:
        # home-manager.url = "";
        # home-manager.inputs.nixpkgs.follows = "";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    # Function (THEY HAVE A SINGLE ARGUMENT) that takes an attribute set as arg
    # The inputs of the function are the ones we've declared above
    # This function can generate different outputs (packages, configurations, shells, ecc.)
    outputs = { nixpkgs, home-manager, unstable, android-nixpkgs, ... } @ inputs: 
        let
            lib = nixpkgs.lib; # Nix Standard Libraries
            system = "x86_64-linux"; # System Architecture that needs to be specified when calling nixpkgs

            # We import the expression stored in "github.../nixpkgs/default.nix" and pass an attribute set with the "system" option
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; }; # Equivalent to "{ system = system }"
            unstablePkgs = import unstable { inherit system; };
        in {

            # Laptop
            nixosConfigurations.nixos = lib.nixosSystem {
                inherit system;
                modules = [ 
                    ./system/laptop.nix 
                    inputs.minegrub-theme.nixosModules.default
                ];
                specialArgs = { inherit pkgs; };
            };

            # Desktop Configuration
            nixosConfigurations.desktop = lib.nixosSystem {
                inherit system;
                modules = [ ./system/desktop.nix ];
                specialArgs = { inherit pkgs; };
            };

            homeConfigurations = {
                # Function, inside home-manager Lib, that creates the output used by home-manager
                dieal = home-manager.lib.homeManagerConfiguration {
                    # Inputs of the function
                    inherit pkgs; 
                    extraSpecialArgs = { unstable = unstablePkgs; };
                    modules = [ 
                        ./home.nix 
                    ];
                };

            };

            packages.x86_64-linux.android-sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
                    cmdline-tools-latest
                    build-tools-34-0-0
                    platform-tools
                    platforms-android-34
                    emulator
            ]);
        };
}
