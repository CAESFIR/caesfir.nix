{ config, lib, pkgs, modulesPath, inputs, ... }:

{

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      users.Feral = {
        home = {
          stateVersion = "26.11";
          username = "Feral";
          homeDirectory = "/home/Feral";
          };
        imports = [
          ../user/modules.nix
          ../user/programs.nix
          ../user/spicetify.nix
          ../user/variables.nix
          ];
        };
      };

}
