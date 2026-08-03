{ config, lib, pkgs, modulesPath, inputs, ... }:

{

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.CAESFIR = ../home.nix;
    };

}
