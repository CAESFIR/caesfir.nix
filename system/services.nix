{ config, lib, pkgs, modulesPath, inputs, ... }:

{

# Services
  services = {
  # PPD
    power-profiles-daemon.enable = true;
  # UPower
    upower.enable = true;
  # envfs
    envfs = {
      enable = true;
    };
  # aria2
#     aria2 = {
#       enable = true;
#     };
  # fwupd
    fwupd = {
      enable = true;
      extraRemotes = [ "vendor-directory" "lvfs-embargo" "lvfs-testing" "lvfs" ];
    };
  # X
    xserver = {
      videoDrivers = [ "nvidia" ];
    };
  # Pipewire
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      socketActivation = true;
      raopOpenFirewall = true;
      systemWide = false; # Do NOT enable this.
      };
  # Flatpak
    flatpak.enable = true;
  # Desktop Manager
    desktopManager = {
    # Cosmic
      cosmic = {
        enable = true;
        xwayland.enable = true;
      };
    # KDE Plasma
      plasma6 = {
        enable = true;
      };
    # GNOME
      gnome = {
        enable = true;
      };
    };
  # Display Manager
    displayManager = {
      enable = true;
    # Plasma Login Manager
      plasma-login-manager.enable = true;
    };
  };

}
