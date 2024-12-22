# Every nix flake evaluates to an expression. In this case it evaluates to an ATTRIBUTE SET
{ 
    description = "Home Manager"; # Optional

    inputs = { 
        # I could name these as I liked.
        nixpkgs.url = "nixpkgs/23.11";
        unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        # The dot notation is a shortcut. I could write:
        # home-manager.url = "";
        # home-manager.inputs.nixpkgs.follows = "";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # Function (THEY HAVE A SINGLE ARGUMENT) that takes an attribute set as arg
    # The inputs of the function are the ones we've declared above
    # This function can generate different outputs (packages, configurations, shells, ecc.)
    outputs = { nixpkgs, home-manager, unstable, ... } @ inputs: 
        let
            lib = nixpkgs.lib; # Nix Standard Libraries
            system = "x86_64-linux"; # System Architecture that needs to be specified when calling nixpkgs

            # We import the expression stored in "github.../nixpkgs/default.nix" and pass an attribute set with the "system" option
            pkgs = import nixpkgs { inherit system; }; # Equivalent to "{ system = system }"
            unstable = import unstable { inherit system; }; # Equivalent to "{ system = system }"
        in {

            homeConfigurations = {
                # Function, inside home-manager Lib, that creates the output used by home-manager
                dieal = home-manager.lib.homeManagerConfiguration {
                    # Inputs of the function
                    inherit pkgs; 
                    modules = [ 
                        ./home.nix 
                        # ./modules/config/shell.nix
                        # ./modules/config/nvim.nix
                    ];
                };
            };
        };
}
