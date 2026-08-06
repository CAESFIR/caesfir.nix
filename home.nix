{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  home.stateVersion = "26.11";

#   programs.plasma = {
#     enable = true;
#     workspace = {
#       cursor = {
#         theme = "Bibata-Modern-Ice";
#         size = 24;
#         };
#       };
#     };

  fonts.fontconfig.enable = false;

  programs = {
    fastfetch = {
    enable = true;
      };
    distrobox = {
      enable = true;
      enableSystemdUnit = true;
      containers = {

      ## Arch
        Arch = {
          entry = true;
          nvidia = true;
          init = false;
          root = false;
          pull = true;
          image = "archlinux:latest";
          home = "/home/CAESFIR/db/home/Arch";
          hostname = "ZIN";
          volume= [ "/ZIN:/ZIN" "/I:/I" "/II:/II" "/III:/III" ];
#          additional_flags = [ "device=nvidia.com/gpu=all" ];
          additional_packages = [ "git" "nano" ];
          };

      # Fedora
        Fedora = {
          entry = true;
          nvidia = true;
          init = false;
          root = false;
          pull = true;
          image = "fedora:rawhide";
          home = "/home/CAESFIR/db/home/Fedora";
          hostname = "ZIN";
          volume= [ "/ZIN:/ZIN" "/I:/I" "/II:/II" "/III:/III" ];
#          additional_flags = [ "device=nvidia.com/gpu=all" ];
          additional_packages = [ "git" ];
          };

      # Debian
        Debian = {
          entry = true;
          nvidia = true;
          init = false;
          root = false;
          pull = true;
          image = "debian:unstable";
          home = "/home/CAESFIR/db/home/Debian";
          hostname = "ZIN";
          volume= [ "/ZIN:/ZIN" "/I:/I" "/II:/II" "/III:/III" ];
#          additional_flags = [ "device=nvidia.com/gpu=all" ];
          additional_packages = [ "git" ];
          };

        };
      };
     };

  home.file.".distroboxrc".text = ''
    container_manager="lilipod"
    export LILIPOD_HOME="/home/CAESFIR/db"
    '';

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LILIPOD_HOME="/home/CAESFIR/db";
    };

  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  home.username = "CAESFIR";
  home.homeDirectory = "/home/CAESFIR";

}
