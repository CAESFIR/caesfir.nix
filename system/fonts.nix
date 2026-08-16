{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;
      includeUserConf = true;
    # Default
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Noto Sans Mono" ];
        serif = [ " Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    # Subpixel
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };
    # Hinting
      hinting = {
        enable = true;
        style = "slight";
      };
    };
  };

}
