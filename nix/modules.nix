{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  imports = with inputs; [
                chaotic.nixosModules.default
                home-manager.nixosModules.home-manager
                ];

}
