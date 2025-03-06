{pkgs, config, ...}: {

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
        android-studio

        # Rust
        rustc
        cargo

        # RISC-V
        rars
    ];
}
