{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  environment = {
    systemPackages = lib.flatten
  ## pkgs
      (with pkgs; [
    ## Discord
      # Stable
        (discord.override {
        withOpenASAR = true;
        })
      # Canary
        (discord-canary.override {
        withOpenASAR = true;
        })
      # Development
        (discord-development.override {
        withOpenASAR = true;
        })
#       # PTB
#         (discord-ptb.override {
# #         withOpenASAR = true;
#         })
        betterdiscord-installer

        (appimage-run.override {
        extraPkgs = pkgs: with pkgs; [
        zstd
        ];
        })
    ## Tools
        curl
        wget
        steamguard-cli
        steamcmd
        efibootmgr
    ## File Systems
        btrfs-progs                     # BTRFS
        e2fsprogs                       # EXT4
        ntfsprogs-plus                  # NTFS
        exfatprogs                      # EXFAT
        dosfstools                      # FAT32
        mtools                          # FAT32
    ## UUPdump
#         aria2
#         cabextract
#         wimlib
#         chntpw
#         cdrtools
    ## Steamy
        jq
        unzip
        libnotify
    ## MSR
        playwright
        typescript
    ## Extras
        kitty
        flatpak-builder
        detect-it-easy
        scanmem
    ## inputs
        (with inputs; [
          nixos-conf-editor.packages.${stdenv.hostPlatform.system}.nixos-conf-editor
          nix-software-center.packages.${stdenv.hostPlatform.system}.nix-software-center
        ])
      ]);
  };

}
