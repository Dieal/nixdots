{ pkgs ? import <nixpkgs> {} }: pkgs.callPackage (
        {
        mkShell,
        cargo,
        rustc,
        }:
        mkShell {
            strictDeps = true;
            nativeBuildInputs = [
                cargo
                rustc
            ];
        }
) { }
