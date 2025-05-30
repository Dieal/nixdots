{pkgs, config, unstable, ...}: 

let
jdkWithFX = pkgs.jdk.override {
    enableJavaFX = true; # for JavaFX
    openjfx_jdk = pkgs.openjfx.override { withWebKit = true; };
};
in
{

    home.packages = with pkgs; [
        gnumake

        live-server

        # PHP
        php84
        php84Packages.composer

        # Python
        uv # Python Package Manager
        
        # Java
        maven
        jdkWithFX

        # Rust
        rustc
        clippy
        cargo

        # RISC-V
        rars
    ];
}
