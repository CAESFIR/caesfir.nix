{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  imports = with inputs; [
                chaotic.nixosModules.default
                home-manager.nixosModules.home-manager
                nur.modules.nixos.default
                nix-ld.nixosModules.nix-ld
                ];

}
