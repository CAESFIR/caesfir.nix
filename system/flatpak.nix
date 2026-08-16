{ config, lib, pkgs, modulesPath, inputs, ... }:

let
  desiredFlatpaks = [
GPU Screen Recorder           com.dec05eba.gpu_screen_recorder           6.0.0                         stable          flathub               system
Discord                       com.discordapp.Discord                     1.0.154                       stable          flathub               system
Protontricks                  com.github.Matoking.protontricks           1.14.1                        stable          flathub               system
Flatseal                      com.github.tchx84.Flatseal                 2.4.1                         stable          flathub               system
ElectronMail                  com.github.vladimiry.ElectronMail          5.3.8                         stable          flathub               system
Easy Effects                  com.github.wwmm.easyeffects                8.2.8                         stable          flathub               system
Heroic                        com.heroicgameslauncher.hgl                v2.22.1                       stable          flathub               system
Modrinth App                  com.modrinth.ModrinthApp                   0.17.6                        stable          flathub               system
OBS Studio                    com.obsproject.Studio                      32.2.2                        beta            flathub-beta          system
RustDesk                      com.rustdesk.RustDesk                      1.4.9                         stable          flathub               system
Spotify                       com.spotify.Client                         1.2.95.453.g0eeebbed          stable          flathub               system
Bottles                       com.usebottles.bottles                     66.6                          stable          flathub               system
Steam                         com.valvesoftware.Steam                    1.0.0.87                      beta            flathub-beta          system
ProtonPlus                    com.vysp3r.ProtonPlus                      0.6.4                         stable          flathub               system
XIVLauncher                   dev.goats.xivlauncher                      1.4.0                         stable          flathub               system
Overlayed                     dev.overlayed.Overlayed                    0.6.2                         stable          flathub               system
Vesktop                       dev.vencord.Vesktop                        1.6.5                         stable          flathub               system
Ente Auth                     io.ente.auth                               4.4                           stable          flathub               system
Amethyst Mod Manager          io.github.Amethyst.ModManager              2.2.0                         beta            amethyst              system
Faugus                        io.github.Faugus.faugus-launcher           2.1.0-1                       stable          flathub               system
Soundux                       io.github.Soundux                          0.2.7                         stable          flathub               system
CrossMacro                    io.github.alper_han.crossmacro             1.3.1                         stable          flathub               system
            1.8.10                        stable          flathub               system
             0.99.16                       stable          flathub               system
                  0.9.3                         stable          flathub               system
             1.2.0                         stable          flathub               system
Gear Lever                    it.mijorus.gearlever                       4.6.2                         stable          flathub               system
Obsidian                      md.obsidian.Obsidian                       1.13.7                        stable          flathub               system
                   3.6.14                        stable          flathub               system
Lutris                        net.lutris.Lutris                          0.5.22                        stable          flathub               system
Dolphin Emulator              org.DolphinEmu.dolphin-emu                 2606-302                      beta            dolphin               system
                    14.0.0                        stable          flathub               system
Firefox                       org.mozilla.firefox                        154.0b10                      beta            flathub-beta          system
Thunderbird                   org.mozilla.thunderbird                    154.0b4                       beta            flathub-beta          system
Prism Launcher                org.prismlauncher.PrismLauncher            11.0.3                        stable          flathub               system
qBittorrent                   org.qbittorrent.qBittorrent                5.2.3                         stable          flathub               system
Telegram                      org.telegram.desktop                       7.0.9                         beta            flathub-beta          system
waywallen                     org.waywallen.waywallen                    0.3.4                         stable          flathub               system
Cider                         sh.cider.Cider                             4.0.9.1                       stable          flathub               system

  ];
  flatpakScript = pkgs.writeScript "flatpak-management" ''
    #!${pkgs.runtimeShell} -e
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Get currently installed Flatpaks
    installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

    # Remove Flatpaks not in the desired list
    for installed in $installedFlatpaks; do
      if ! echo ${lib.concatStringsSep " " desiredFlatpaks} | grep -q "$installed"; then
        echo "Removing $installed because it's not in the desiredFlatpaks list."
        ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive "$installed"
      fi
    done

    # Install or re-install desired Flatpaks
    for app in ${lib.concatStringsSep " " desiredFlatpaks}; do
      echo "Ensuring $app is installed."
      ${pkgs.flatpak}/bin/flatpak install -y --noninteractive flathub "$app"
    done

    # Remove unused Flatpaks
    ${pkgs.flatpak}/bin/flatpak uninstall --unused -y --noninteractive

    # Update all installed Flatpaks
    ${pkgs.flatpak}/bin/flatpak update -y --noninteractive
  '';
in
{
  systemd.services.flatpak-management = {
    description = "Manage Flatpak installations";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${flatpakScript}";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.timers.flatpak-management = {
    description = "Run flatpak management periodically";
    timerConfig = {
      OnCalendar = "daily";
      Persistent = "true";
    };
    wantedBy = ["timers.target"];
  };
}
