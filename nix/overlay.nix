{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.millennium.overlays.default
    ];

}
