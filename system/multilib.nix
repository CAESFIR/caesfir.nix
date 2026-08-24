{ config, lib, pkgs, modulesPath, inputs, ... }:

{

hardware.graphics.enable32Bit = true;

fonts.fontconfig.cache32Bit = true;

services = {
  pipewire.alsa.support32Bit = true;
  pulseaudio.support32Bit = true;
  jack.alsa.support32Bit = true;
  };

}
