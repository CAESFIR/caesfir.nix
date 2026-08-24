{ config, lib, pkgs, modulesPath, inputs, ... }:

{

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
    LILIPOD_HOME="/home/Feral/db";
    };

  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

}
