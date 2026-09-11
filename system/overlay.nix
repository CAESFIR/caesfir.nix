{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.millennium.overlays.default
    (final: prev: {
      inherit (prev.lixPackageSets.latest)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena;
      })
        ];

}
