{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  system.stateVersion = "26.11";

  ### Import
  imports =
    [
    ### Nix
      ../system/boot.nix
      ../system/chaotic.nix
      ../system/environment.nix
      ../system/exclude.nix
      ../system/fileSystems.nix
      ../system/fonts.nix
      ../system/hardware.nix
      ../system/libraries.nix
      ../system/modules.nix
      ../system/multilib.nix
      ../system/overlay.nix
      ../system/programs.nix
      ../system/services.nix
      ../system/virtualisation.nix
    ];

    nix.extraOptions = ''
      !include /etc/nix/git.conf
    '';

    appstream.enable = true;
  # XDG
    xdg = {
      autostart = {
        enable = true;
        install = true;
        };
      icons.enable = true;
      menus.enable = true;
      mime.enable = true;
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        };
      sounds.enable = true;
      };

    environment = {
      homeBinInPath = true;
      localBinInPath = true;
      stub-ld.enable = true;
      sessionVariables = {
        PATH = [
          "/ZIN/PATH"
          ];
        XDG_DESKTOP_DIR      =  "/ZIN/Linux/XDG/Desktop";
        XDG_DOCUMENTS_DIR    =  "/ZIN/Linux/XDG/Documents";
        XDG_DOWNLOAD_DIR     =  "/ZIN/Linux/XDG/Downloads";
        XDG_MUSIC_DIR        =  "/ZIN/Linux/XDG/Music";
        XDG_PICTURES_DIR     =  "/ZIN/Linux/XDG/Pictures";
        XDG_PROJECTS_DIR     =  "/ZIN/Linux/XDG/Projects";
        XDG_PUBLICSHARE_DIR  =  "/ZIN/Linux/XDG/Public";
        XDG_TEMPLATES_DIR    =  "/ZIN/Linux/XDG/Templates";
        XDG_VIDEOS_DIR       =  "/ZIN/Linux/XDG/Videos";
        };
      };

  # Hyprland Cachix
    nix.settings = {
     substituters = ["https://hyprland.cachix.org"];
     trusted-substituters = ["https://hyprland.cachix.org"];
     trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

  # Sudo password
  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
      Defaults insults
      '';
  };

  # Electron Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LILIPOD_HOME="/home/Feral/db";
  };

  networking.nftables.enable = true;

  # Host Name
  networking.hostName = "ZIN"; # Hostname

  # Time Zone
  time.timeZone = "Asia/Kolkata"; # Timezone

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  security.rtkit.enable = true;

 # QT
  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "kde";
    };

 # Locales
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

# System
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://channels.nixos.org/nixos-unstable";
      operation = "boot";
      runGarbageCollection = true;
      upgrade = true;
        };
#     nixos = {
#       codeName = "";
#       label = "";
#       release = "";
#       variantName = "";
#         };
    switch = {
      enable = true;
        };
      };
  
# Nix
  nix = {
    enable = true;
    channel.enable = true;
    checkConfig = true;
    daemon = {
      enable = true;
        };
    daemonUser = "root";
    daemonGroup = "root";
    daemonIOSchedClass = "best-effort";
    daemonIOSchedPriority = 3;
    daemonCPUSchedPolicy = "batch";
    firewall = {
      enable = false;
        };
    optimise = {
      automatic = true;
        };
    gc = {
      automatic = true;
        };
    settings = {
      cores = 4;
      max-jobs = 4;
      sandbox = true;
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      download-buffer-size = 10000000000;
        };
    };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ### UnFree
  nixpkgs.config.allowUnfree = true;

  ### Users / Groups
  users.users.Feral = {
    shell = pkgs.zsh;
    isNormalUser = true;
    uid = 1000;
    group = "Feral";
    extraGroups = [ "Feral" "wheel" "gamemode" ];
    packages = with pkgs; [
      ];
    subGidRanges = [{
        count = 65536;
        startGid = 100000;
      }];
    subUidRanges = [{
        count = 65536;
        startUid = 100000;
      }];
    };

  users.groups.Feral = {
    gid = 1000;
  };

  networking.firewall.enable = false;

}

