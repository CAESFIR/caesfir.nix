{ config, lib, pkgs, modulesPath, inputs, ... }:

{

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.CAESFIR = {
        home = {
          stateVersion = "26.11";
          username = "CAESFIR";
          homeDirectory = "/home/CAESFIR";
          };
        imports = [
          ../user/programs.nix
          ../user/variables.nix
          ];
        };
      };

}
