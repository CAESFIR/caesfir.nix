{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  system.stateVersion = "26.11";

  ### Import
  imports =
    [
      ./nix/boot.nix
      ./nix/environment.nix
      ./nix/fonts.nix
      ./nix/hardware.nix
      ./nix/hm.nix
      ./nix/libraries.nix
      ./nix/modules.nix
      ./nix/multilib.nix
      ./nix/overlay.nix
      ./nix/programs.nix
      ./nix/services.nix
      ./nix/virtualisation.nix
    ];

    nix.extraOptions = ''
      !include /etc/nix/git.conf
    '';

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

  qt.platformTheme = "kde";

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

  ### XDG Portal
  xdg.portal.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

}

