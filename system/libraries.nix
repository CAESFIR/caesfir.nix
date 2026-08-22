{ config, lib, pkgs, modulesPath, inputs, ... }:


{

  programs = {
    nix-ld = {
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
    # Non default
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

}
