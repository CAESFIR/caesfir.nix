{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  system.stateVersion = "26.11";

  ### Import
  imports =
    [
    ### Nix
      ../system/boot.nix
      ../system/environment.nix
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
      XDG_DESKTOP_DIR="/I/Home/Desktop";
      XDG_DOWNLOAD_DIR="/I/Home/Downloads";
      XDG_PUBLICSHARE_DIR="/I/Home/Public";
      XDG_PROJECTS_DIR="/I/Home/Projects";
      XDG_TEMPLATES_DIR="/I/Home/Templates";
      XDG_DOCUMENTS_DIR="/I/Home/Documents";
      XDG_PICTURES_DIR="/I/Home/Pictures";
      XDG_MUSIC_DIR="/I/Home/Music";
      XDG_VIDEOS_DIR="/I/Home/Videos";
        };
      };

  # Hyprland Cachix
    nix.settings = {
     substituters = ["https://hyprland.cachix.org"];
     trusted-substituters = ["https://hyprland.cachix.org"];
     trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
     trusted-users = ["root" "@wheel"];
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
    LILIPOD_HOME="/home/CAESFIR/db";
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

# Nix Settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 10000000000;
  };

 # Locales
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

# System
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    };
  
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "00:00" ];
  nix.settings.auto-optimise-store = true;
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  ### UnFree
  nixpkgs.config.allowUnfree = true;

  ### Users / Groups
  users.users.CAESFIR = {
    shell = pkgs.zsh;
    isNormalUser = true;
    uid = 1000;
    group = "CAESFIR";
    extraGroups = [ "CAESFIR" "wheel" "gamemode" ];
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

  users.groups.CAESFIR = {
    gid = 1000;
  };

  networking.firewall.enable = false;

}

