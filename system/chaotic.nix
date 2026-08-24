{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  chaotic = {
    nyx = {
      cache = {
        enable = true;
        };
      nixPath = {
        enable = true;
        };
      overlay = {
        enable = true;
        };
      registry = {
        enable = true;
        };
      };
    };

}
