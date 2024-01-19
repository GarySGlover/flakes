{
  description = "GarySGlover Nix Package Repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ inputs: (flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

    lib = pkgs.lib;

    nimPackageDirs = lib.filterAttrs (
      name: type: type == "directory"
    ) (builtins.readDir ./nim);

    importNimPackage = name: value: (
      import (./. + "/nim/${name}") {
        inherit pkgs pkgs-unstable packages;
        buildNimPackage = pkgs.nimPackages.buildNimPackage;
        fetchFromGitHub = pkgs.pkgs.fetchFromGitHub;
      }
    );

    packages = lib.mapAttrs importNimPackage nimPackageDirs;
  in rec {
    inherit packages;
  }));
}
