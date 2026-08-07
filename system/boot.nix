{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

### Boot
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" ];
      kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      extraFiles = {
      "/lib/firmware/edid/DP-3".source = ../edid/DP-3;
      "/lib/firmware/edid/HDMI-A-1".source = ../edid/HDMI-A-1;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "kvm-amd" "ntsync" ];
    kernelParams = [ "loglevel=0" "udev.log_level=3" "quiet" "splash" "nosgx" "mitigations=off" "drm.edid_firmware=DP-3:edid/DP-3,HDMI-A-1:edid/HDMI-A-1" ];
    extraModprobeConfig = ''
      options snd-hda-intel patch=hda-jack-retask.fw
    '';
  };

### SSD

 ## ZIN | /dev/sda1 | /ZIN
  fileSystems."/ZIN" =
    { device = "/dev/disk/by-uuid/11111111-7469-7469-7469-111111111111";
      fsType = "btrfs";
      options = [ "nofail" "ssd" "rw" "exec" "noatime" "discard=async" "barrier" "datacow" "datasum" "autodefrag" "flushoncommit" "space_cache=v2" "compress-force=zstd:15" "commit=60" "thread_pool=6" ];
    };

 ## Root | /dev/sda2 | /
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/22222222-7469-7469-7469-222222222222";
      fsType = "btrfs";
      options = [ "ssd" "rw" "exec" "relatime" "discard=async" "barrier" "datacow" "datasum" "autodefrag" "flushoncommit" "space_cache=v2" "compress-force=zstd:15" "commit=1" "thread_pool=6" ];
    };

 ## Boot | /dev/sda3 | /boot
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3333-7469";
      fsType = "vfat";
      options = [ "rw" "relatime" "umask=0022" "shortname=mixed" "utf8" "errors=remount-ro"];
    };

### HDD

 ## I    | /dev/sdb1 | /I
  fileSystems."/I" =
    { device = "/dev/disk/by-uuid/11111111-1111-1111-1111-111111111111";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
    };

 ## II   | /dev/sdb2 | /II
  fileSystems."/II" =
    { device = "/dev/disk/by-uuid/22222222-2222-2222-2222-222222222222";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
    };

 ## III  |  /dev/sdb3 | /III
  fileSystems."/III" =
    { device = "/dev/disk/by-uuid/33333333-3333-3333-3333-333333333333";
      fsType = "ext4";
      options = [ "nofail" "rw" "exec" "noatime" "data=writeback" "commit=60" ];
    };

### ZRAM
  services.zram-generator = {
    enable = true;
    settings = {
      zram0 = {
        zram-size = 8192;
        compression-algorithm = "zstd";
        swap-priority = 100;
        fs-type = "swap";
      };
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

### Grub
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
  # Playmouth
    plymouth = {
      enable = true;
      themePackages = with pkgs; [(
        adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })];
      theme = "lone";
      };
    loader = {
  # EFI
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
        };
    # GRUB
      grub = {
        enable = true;
        default = "saved";
        efiSupport = true;
        configurationName = "Nix";
        configurationLimit = 3;
        gfxpayloadEfi = "keep";
        gfxmodeEfi = "2560x1440x32";
        splashMode = "normal";
        theme = (pkgs.sleek-grub-theme.override {
        withBanner = "Hi Feral,";
        withStyle = "bigSur";
        });
        extraEntries = ''

          menuentry "Arch" --class arch {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 5555-7469
          chainloader /EFI/Arch/grubx64.efi
          }

          menuentry "Windows" --class windows {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --fs-uuid --set=root 6666-6666
          chainloader /EFI/Boot/bootx64.efi
          }

          menuentry "UEFI" --class efi {
          fwsetup
          }

        '';
        mirroredBoots = [
          {
           devices = [ "nodev" ];
           path = "/boot";
           efiBootloaderId = "Nix";
          }
        ];
      };
    };
  };

}
