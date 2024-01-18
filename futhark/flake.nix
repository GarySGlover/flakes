{
  description = "Futhark";
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
    fetchFromGitHub = pkgs.fetchFromGitHub;
    nimPackages = pkgs.nimPackages;
  in rec {
    packages.libclang = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "libclang";
      version = "14594ef";
      nimBinOnly = false;

      src = fetchFromGitHub {
        owner = "PMunch";
        repo = "libclang-nim";
        rev = "${finalAttrs.version}";
        sha256 = "sha256-SXsD/sKyfWM+XK4KgXlKiknqZT7vHREpU46z6TKfek0=";
      };
    });

    packages.nimbleutils = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "nimbleutils";
      version = "0.3.1";
      nimBinOnly = false;

      src = fetchFromGitHub {
        owner = "PMunch";
        repo = "nimbleutils";
        rev = "v${finalAttrs.version}";
        sha256 = "sha256-/ru8de8t3D5KZ0siiFAB+ak1PgmIBISQhpfczowKe10=";
      };
    });

    packages.termstyle = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "termstyle";
      version = "eefd9f1";
      nimBinOnly = false;

      src = fetchFromGitHub {
        owner = "PMunch";
        repo = "termstyle";
        rev = "${finalAttrs.version}";
        sha256 = "sha256-PuvUfjskKI5IA4cAOQ6RugHrVyFit1ihGr4vIDymiLI=";
      };
    });

    packages.macroutils = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "macroutils";
      version = "1.2.0";
      nimBinOnly = false;

      src = fetchFromGitHub {
        owner = "PMunch";
        repo = "macroutils";
        rev = "v${finalAttrs.version}";
        sha256 = "sha256-HGsNbldfhjAEaKsj+DZuMDwhhaLWHlibOWZ3xklKEds=";
      };
    });

    packages.futhark = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "futhark";
      version = "0.12.0";
      nimBinOnly = true;

      src = fetchFromGitHub {
        owner = "PMunch";
        repo = "futhark";
        rev = "v${finalAttrs.version}";
        sha256 = "sha256-CfnnFwnnr5uvqr4H3t5ZN/kHor1ngvL9OhAQ3fD6xik=";
      };

      buildInputs = with packages;
        [
          libclang
          nimbleutils
          termstyle
          macroutils
        ]
        ++ (with pkgs.nimPackages; [
          ])
        ++ (with pkgs; [
          libclang
        ]);

      doCheck = false; # Tests faile trying to find opir
    });
  }));
}
