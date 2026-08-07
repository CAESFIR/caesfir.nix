{ config, lib, pkgs, modulesPath, inputs, ... }:

let
  desiredFlatpaks = [
    "com.dec05eba.gpu_screen_recorder"   # GPU Screen Recorder
    "com.discordapp.Discord"             # Discord
    "com.github.Matoking.protontricks"   # Protontricks
    "com.github.tchx84.Flatseal"         # Flatseal
    "com.github.vladimiry.ElectronMail"  # Electron Mail
    "com.github.wwmm.easyeffects"        # Easy Effects
    "com.heroicgameslauncher.hgl"        # Heroic
    "com.modrinth.ModrinthApp"           # Modrinth
    "com.obsproject.Studio"              # OBS Studio
    "com.rustdesk.RustDesk"              # RustDesk
    "com.spotify.Client"                 # Spotify                    # X
    "com.usebottles.bottles"             # Bottles
    "com.valvesoftware.Steam"            # Steam                      # X
    "com.vysp3r.ProtonPlus"              # ProtonPlus
    "dev.goats.xivlauncher"              # XIVLauncher
    "dev.overlayed.Overlayed"            # Overlayed
    "dev.vencord.Vesktop"                # Vesktop
    "io.ente.auth"                       # Ente Auth
    "io.github.Faugus.faugus-launcher"   # Faugus
    "io.github.Soundux"                  # Soundux
    "io.github.alper_han.crossmacro"     # CrossMacro
    "io.github.benjamimgois.goverlay"    # Goverlay
    "io.github.kolunmi.Bazaar"           # Bazaar
    "io.missioncenter.MissionCenter"     # Mission Center
    "it.mijorus.gearlever"               # Gear Lever
    "md.obsidian.Obsidian"               # Obsidian                   # X
    "net.cozic.joplin_desktop"           # Joplin                     # X
    "net.lutris.Lutris"                  # Lutris
    "org.mozilla.firefox"                # Firefox
    "org.mozilla.thunderbird"            # Thunderbird
    "org.qbittorrent.qBittorrent"        # qBittorrent
    "org.telegram.desktop"               # Telegram
    "org.waywallen.waywallen"            # waywallen
    "sh.cider.Cider"                     # Cider
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
