{
  description = "Application 1";
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
    packages.ttop = pkgs.nimPackages.buildNimPackage (finalAttrs: {
      pname = "ttop";
      version = "1.0.1";
      nimBinOnly = true;

      src = fetchFromGitHub {
        owner = "inv2004";
        repo = "ttop";
        rev = "v${finalAttrs.version}";
        sha256 = "sha256-x4Uczksh6p3XX/IMrOFtBxIleVHdAPX9e8n32VAUTC4=";
      };

      buildInputs = with pkgs.nimPackages; [asciigraph illwill parsetoml zippy];
    });
  }));
}
