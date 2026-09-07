{ config, lib, pkgs, modulesPath, inputs, ... }:

{

hardware.graphics.enable32Bit = true;

services.pipewire.alsa.support32Bit = true;

fonts.fontconfig.cache32Bit = true;

}
