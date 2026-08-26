{
  description = "Nix Flake";

  inputs = {
### Core
   # NixPKGs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
   # Chaotic Nyx
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
   # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # NUR
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      };
### Configs
   # Nix Software Center
    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # NixOS Conf Editor
    nixos-conf-editor = {
      url = "github:snowfallorg/nixos-conf-editor";
      inputs.nixpkgs.follows = "nixpkgs";
      };
### Apps
   # FireFox Nightly
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # Steam Millennium
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      };
### WM
   # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      };
   # Quickshell
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # Noctalia
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # Caelestia
    caelestia = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      };
### Tools
   # Plasma Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      };
   # Nix LD
    nix-ld = {
      url = "github:nix-community/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
      };
   # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      };
### Third Party

  ## Spicetify
    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      };

##### Flake-Less

  };

  outputs = inputs@{
    self,
    nixpkgs,                       # NixPKGs
    chaotic,                       # Chaotic Nyx
    home-manager,                  # Home Manager
    nur,                           # NUR
    nix-software-center,           # Nix Software Center
    nixos-conf-editor,             # NixOS Conf Editor
    firefox-nightly,               # Firefox Nightly
    millennium,                    # Steam Millennium
    hyprland,                      # Hyprland
    quickshell,                    # Quickshell
    noctalia,                      # Noctalia Shell
    caelestia,                     # Caelestia Shell
    plasma-manager,                # Plasma Manager
    nix-ld,                        # LD
    stylix,                        # Stylix
    spicetify,                     # Spicetify
    ...
    }: {

  # Nix
    nixosConfigurations = {
      ZIN = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./main/system.nix
          ./main/user.nix
        ];
      };
    };

  };
}
