{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  environment = {

  ## Plasma
    plasma6.excludePackages = with pkgs.kdePackages; [
      kwin-x11
      ocean-sound-theme
      plasma-keyboard
      qtvirtualkeyboard
      baloo
      milou
      drkonqi
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
