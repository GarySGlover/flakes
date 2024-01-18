{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "termstyle";
  version = "0-unstable";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "PMunch";
    repo = "termstyle";
    rev = "eefd9f17071df2b8c13e18537cd799acd7f41501";
    sha256 = "sha256-PuvUfjskKI5IA4cAOQ6RugHrVyFit1ihGr4vIDymiLI=";
  };
})
