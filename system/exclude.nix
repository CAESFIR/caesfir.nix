{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  environment = {

  ## Plasma
    plasma6.excludePackages = with pkgs.kdePackages; [
      baloo
      milou
      drkonqi
      ocean-sound-theme
      kdeplasma-addons
      kinfocenter
      kwin-x11
      elisa
      okular
      khelpcenter
      baloo-widgets
      krdp
      plasma-keyboard
      qtvirtualkeyboard
      ];

  ## GNOME
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
      baobab
      decibels
      epiphany
      gnome-text-editor
      gnome-calculator
      gnome-calendar
      gnome-clocks
      gnome-console
      gnome-contacts
      gnome-font-viewer
      gnome-logs
      gnome-maps
      gnome-music
      gnome-system-monitor
      gnome-tecla
      gnome-weather
      loupe
      nautilus
      papers
      gnome-connections
      showtime
      simple-scan
      snapshot
      yelp
      ];

  ## Cosmic
    cosmic.excludePackages = with pkgs; [
      ];

    };

}
