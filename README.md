# feral.nix
Just a backup of my nix configs.

If you want to use it, feel free to. However keep in mind that you may have to make some changes. These are some of the more important configs to keep in mind:
- Meant to target Nvidia 16xx series and above GPUs, so you might wanna consider removing some configs while editing others if you use an AMD / Intel, or an older EOL Nvidia GPU.
- Uses Lix instead of Nix as package manager.
- nix-ld is being used to make some FHS applications run normally(-ish).
- Plasma, GNOME, Cosmic, and Hyprland. All are installed by default.
- Plentiful of Plasma and GNOME packages have been excluded to avoid (what I consider) bloat.
- Plasma Login Manager is used as the default DM.
- Xwayland is enabled by default for all DEs and WMs.
- Username, hostname, timezone, filesystems, and directories. Even if you don't bother with configuring the first three, you must do so with the last two.
- There are no scripts in the configs at all (at least for now).
- There are plentiful of flakes which are currently going unused (by me), but I have still decided to keep them in case I actually ever bother to use them.

| Directories | File types |
|:---:|:---|
| edid | Contains custom EDID files for my monitors. |
| fw | Currently only contains custom .fw files for my audio. |
| main | Main configuration files; imports from `system` and `user`. |
| system | System configuration files. |
| user | User configuration files. |
