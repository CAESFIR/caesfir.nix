{ config, lib, pkgs, modulesPath, inputs, ... }:


{

  programs = {
    nix-ld = {
      enable = false;
      dev = {
        enable = true;
        libraries = with pkgs; [
    # Default
          zlib
          zstd
          stdenv.cc.cc.lib
          curl
          openssl
          attr
          libssh
          bzip2
          libxml2
          acl
          libsodium
          util-linux
          xz
          systemd
    # Impportant
          mesa
          vulkan-loader
          dbus
          ffmpeg
          wayland
          pipewire
          fontconfig
          freetype
          libxkbcommon
          glib
          alsa-lib
          sdl3
    # Test
          SDL2
          libGL
          libGLX
          libGLU
          libglvnd
          libgbm
          icu
          libunwind
          libuuid
          nss
          nspr
          atk
          cairo
          gtk3
          pango
          expat
          qt6.qtbase
          qt6.qtdeclarative
          qt6.qtwayland
    # Xorg | X11
          libx11
          libxext
          libxcursor
          libxdamage
          libxfixes
          libxi
          libxrandr
          libxrender
          libxcomposite
          libxcb
          libxmu
    # Discord
          ];
        };
      };
    };

}
