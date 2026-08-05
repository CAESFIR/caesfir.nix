{ config, lib, pkgs, modulesPath, inputs, ... }:

{

  security.pam.services.plasmalogin.enableGnomeKeyring = true;

  programs = {
    npm = {
      enable = true;
      };
  # FireFox
    firefox = {
      enable = true;
      package = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
      languagePacks = [ "en-US" ];
      nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];
    };
    nix-index = {
      enable = true;
    };
  # Starship
    starship = {
      enable = true;
    };
  # Plasma Browser Integration
    chromium.enablePlasmaBrowserIntegration = true;
  # ZSH
    zsh = {
      enable = true;
    };
  # Password
    ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse.out}/libexec/seahorse/ssh-askpass";
    seahorse.enable = true;
  # Git
    git.enable = true;
  # KDEConnect
    kdeconnect.enable = true;
  # CoolerControl
    coolercontrol.enable = true;
  # Hyprland
#     hyprland = {
#       enable = true;
#       withUWSM = true;
#       xwayland.enable = true;
#     };
  # XWayland
    xwayland.enable = true;
  # AppImage
    appimage = {
      enable = true;
      binfmt = true;
    };
  # Gamemode
    gamemode = {
      enable = true;
      enableRenice = true;
#       settings = {
#         general = {
#           desiredgov="performance";
#           desiredprof="performance";
#           softrealtime="on";
#           renice=10;
#           ioprio=0;
#           inhibit_screensaver=1;
#           disable_splitlock=1;
#         };
#         cpu = {
#         };
#         gpu = {
#           apply_gpu_optimisations ="accept-responsibility";
#           gpu_device =1;
#           nv_powermizer_mode=1;
#           nv_per_profile_editable =1;
#           nv_core_clock_mhz_offset=0;
#           nv_mem_clock_mhz_offset=0;
#         };
#       };
    };
  # Gamescope
    gamescope = {
      enable = true;
      enableWsi = true;
      capSysNice = true;
#       args = [
#         ];
#       env = {
#       };
    };
  # Steam
    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      extest.enable = true;
      gamescopeSession = {
        enable = true;
        steamArgs = [
#         "-tenfoot"
#         "-pipewire-dmabuf"
        ];
        args = [
#         "--filter=fsr"
#         "--sharpness=10"
#          "--expose-wayland"
#          "--backend=drm"
#          "--rt"
#          "--steam"
#         "--prefer-vk-device=10de:21c4"
#         "--force-orientation=normal"
#         "--force-windows-fullscreen"
#         "--hdr-enabled"
#         "--sdr-gamut-wideness=1"
#         "--hdr-sdr-content-nits=250"
#         "--hdr-itm-enabled"
#         "--hdr-itm-sdr-nits=100"
#         "--hdr-itm-target-nits=400"
#         "--adaptive-sync"
#         "--prefer-output=DP-3"
#         "--generate-drm-mode=fixed"
#         "--immediate-flips"
#         "--keep-alive"
        ];
        env = {
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

}
