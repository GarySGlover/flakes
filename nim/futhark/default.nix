{
  pkgs,
  buildNimPackage,
  fetchFromGitHub,
  packages,
  ...
}:
buildNimPackage (finalAttrs: {
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
})
