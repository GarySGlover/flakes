{
  description = "GarySGlover Nix Package Repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs: (flake-utils.lib.eachDefaultSystem (system: let
    pkgs = nixpkgs.legacyPackages.${system};
    lib = pkgs.lib;

    nimPackageDirs = lib.filterAttrs (name: type: type == "directory") (builtins.readDir ./nim);

    importNimPackage = name: value: (
      import (./. + "/nim/${name}") {
        inherit pkgs;
        buildNimPackage = pkgs.nimPackages.buildNimPackage;
        fetchFromGitHub = pkgs.pkgs.fetchFromGitHub;
        inherit packages;
      }
    );

    packages = lib.mapAttrs importNimPackage nimPackageDirs;
  in rec {
    inherit packages;
  }));
}
