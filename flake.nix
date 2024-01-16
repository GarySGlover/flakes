{
  description = "My Nix Package Repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    ttop.url = "path:./ttop";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ttop,
    ...
  } @ inputs: (flake-utils.lib.eachDefaultSystem (system: let
  in rec {
    packages = {
      ttop = ttop.outputs.packages.${system}.ttop;
    };
  }));
}
