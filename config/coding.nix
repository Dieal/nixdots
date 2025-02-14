{pkgs, config, ...}: {

    home.packages = with pkgs; [
        gnumake

        # PHP
        php84
        php84Packages.composer

        # Python
        uv # Python Package Manager
        
        # Java
        maven
    ];
}
