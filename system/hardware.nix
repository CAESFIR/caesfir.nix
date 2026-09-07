{ config, lib, pkgs, modulesPath, inputs, ... }:

{

# Hardware
  hardware = {
  # Firmware
    enableRedistributableFirmware = true;
  # Bluetooth
    bluetooth.enable = true;
  # Steam Hardware
    steam-hardware.enable = true;
  # Firmware
    firmware = [
     # EDID
      (pkgs.runCommand "edid" {} ''
      mkdir -p $out/lib/firmware/edid
      cp ${../edid/DP-3.bin} $out/lib/firmware/edid/DP-3.bin
      '')
     # HDA-Jack-Retask
      (pkgs.runCommand "audio" {} ''
      mkdir -p $out/lib/firmware
      cp ${../fw/hda-jack-retask.fw} $out/lib/firmware/hda-jack-retask.fw
      '')
    ];
    firmwareCompression = "zstd";
  # Graphics
    graphics = {
      enable = true;
      };

  # CPU
    cpu = {
      amd = {
        updateMicrocode = true;
        };
      intel = {
        updateMicrocode = true;
        };
      };

  # Nvidia
#     nvidia-container-toolkit = {
#       enable = true;
#       mount-nvidia-executables = true;
#       };
    nvidia = {
      open = true;
      nvidiaPersistenced = true;
      nvidiaSettings = true;
      videoAcceleration = true;
      branch = "bleeding_edge";
      gsp.enable = true;
      modesetting.enable = true;
      dynamicBoost.enable = true;
    # Power Management
      powerManagement = {
        enable = true;
        finegrained = false;
        kernelSuspendNotifier = true;
      };
    };
  };

}
