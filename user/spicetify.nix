{ config, lib, pkgs, modulesPath, inputs, ... }:

let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
#     theme = {
#       homeConfig = true;
#       injectCss = true;
#       injectThemeJs = true;
#       overwriteAssets = true;
#       replaceColors = true;
#       };
    };
}
