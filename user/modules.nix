{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  imports = with inputs; [
                spicetify.homeManagerModules.spicetify
                ];

}
