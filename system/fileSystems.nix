{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  fileSystems = {

### SSD

 ## ZIN | /dev/sda1 | /ZIN
    "/ZIN" = {
      device = "/dev/disk/by-uuid/11111111-7469-7469-7469-111111111111";
      fsType = "btrfs";
      options = [ "ssd" "rw" "exec" "acl" "noatime" "discard=async" "barrier" "datacow" "datasum" "noautodefrag" "noflushoncommit" "space_cache=v2" "compress=zstd:3" "thread_pool=4" "commit=60" ];
      };

 ## Home
    "/home" = {
      device = "/ZIN/Linux/Home/Nix";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/ZIN" ];
      };

 ## Flatpak

  # Flatpak Apps
    "/var/lib/flatpak" = {
      device = "/ZIN/Linux/Flatpak/App";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/ZIN" ];
      };

  # Flatpak Configs
    "/home/Feral/.var/app" = {
      device = "/ZIN/Linux/Flatpak/Config";
      fsType = "none";
      options = [ "bind" ];
      depends = [ "/ZIN" ];
      };

 ## Root | /dev/sda2 | /
    "/" = {
      device = "/dev/disk/by-uuid/22222222-7469-7469-7469-222222222222";
      fsType = "btrfs";
      options = [ "ssd" "rw" "exec" "acl" "noatime" "discard=async" "barrier" "datacow" "datasum" "noautodefrag" "noflushoncommit" "space_cache=v2" "compress=zstd:3" "thread_pool=4" "commit=60" ];
      };

 ## Boot | /dev/sda3 | /boot
    "/boot" = {
      device = "/dev/disk/by-uuid/3333-7469";
      fsType = "vfat";
      options = [ "rw" "relatime" "umask=0022" "shortname=mixed" "utf8" "errors=remount-ro"];
      };

### HDD

 ## I    | /dev/sdb1 | /I
    "/I" = {
      device = "/dev/disk/by-uuid/11111111-1111-1111-1111-111111111111";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
      };

 ## II   | /dev/sdb2 | /II
    "/II" = {
      device = "/dev/disk/by-uuid/22222222-2222-2222-2222-222222222222";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
      };

 ## III  |  /dev/sdb3 | /III
    "/III" = {
      device = "/dev/disk/by-uuid/33333333-3333-3333-3333-333333333333";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
      };

    };

}
