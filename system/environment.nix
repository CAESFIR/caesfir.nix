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
      # PTB
        (discord-ptb.override {
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
      # Vesktop
        vesktop
    ## Tools
        curl
        wget
        wine-staging                    # WINE
        android-translation-layer       # ATL
        lilipod
        arch-install-scripts
        steamguard-cli
        steamcmd
        gparted
#         ouch
        efibootmgr
#         patchelf
#         auto-patchelf
#         unar
#         winetricks
        joplin-desktop
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
    ## MSR
          playwright
          typescript
     ## inputs
        (with inputs; [
          firefox-nightly.packages.${stdenv.hostPlatform.system}.firefox-nightly-bin
          nixos-conf-editor.packages.${stdenv.hostPlatform.system}.nixos-conf-editor
          nix-software-center.packages.${stdenv.hostPlatform.system}.nix-software-center
        ])
      ]);
  };

}
