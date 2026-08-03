{
  description = "Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  ### Configs
    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    nixos-conf-editor = {
      url = "github:snowfallorg/nixos-conf-editor";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  ### Apps
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    millennium = {
      url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  ### Plasma
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      };
  ### WM
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    caelestia = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = inputs@{
    self,
    nixpkgs,                       # NixPKGs
    chaotic,                       # Chaotic Nyx
    home-manager,                  # Home Manager
    nix-software-center,           # Nix Software Center
    nixos-conf-editor,             # Nix Conf Editor
    firefox-nightly,               # Firefox Nightly
    millennium,                    # Millennium
    plasma-manager,                # Plasma Manager
    noctalia,                      # Noctalia Shell
    caelestia,                     # Caelestia Shell
    ...
    }: {

  # Nix
    nixosConfigurations = {
      ZIN = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
