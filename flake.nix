{
    description = "My first Home Manager Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/23.11";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
        in {
            homeConfigurations = {
                dieal = {
                    home-manager.lib.homeManagerConfiguration = {
                        inherit pkgs;
                        modules = [ "./home.nix" ];
                    };
                };
            };
        };
}
