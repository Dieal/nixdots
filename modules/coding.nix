{
  pkgs,
  config,
  unstable,
  lib,
  ...
}: let
  jdkWithFX = pkgs.jdk.override {
    enableJavaFX = true; # for JavaFX
    openjfx_jdk = pkgs.openjfx.override {withWebKit = true;};
  };
in {
  nixpkgs.config.android_sdk.accept_license = true;
  home = {
    packages = with pkgs; [
      gnumake

      live-server

      # PHP
      php84
      php84Packages.composer

      # Python
      uv # Python Package Manager

      # Java
      maven
      jdk
      # jdkWithFX
      jetbrains.idea-ultimate

      # Rust
      rustc
      clippy
      cargo

      vscodium-fhs
      apktool

      # RISC-V
      # rars

      # android-studio
    ];
  };
}
