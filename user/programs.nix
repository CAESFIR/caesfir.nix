{ config, lib, pkgs, modulesPath, inputs, ... }:

{

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
          home = "/home/Feral/db/home/Arch";
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
          home = "/home/Feral/db/home/Fedora";
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
          home = "/home/Feral/db/home/Debian";
          hostname = "ZIN";
          volume= [ "/ZIN:/ZIN" "/I:/I" "/II:/II" "/III:/III" ];
#          additional_flags = [ "device=nvidia.com/gpu=all" ];
          additional_packages = [ "git" ];
          };

        };
      };
    };

}
