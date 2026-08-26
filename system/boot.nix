{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

### Boot
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" ];
      kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      extraFiles = {
      "/lib/firmware/edid/DP-3".source = ../edid/DP-3;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" "kvm-amd" "ntsync" ];
    kernelParams = [ "quiet" "splash" "nosgx" "mitigations=off" "drm.edid_firmware=DP-3:edid/DP-3" ];
    extraModprobeConfig = ''
      options snd-hda-intel patch=hda-jack-retask.fw
    '';
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

  boot = {
    tmp = {
      useTmpfs = true;
#       useZram = true;
      };
    };

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
