{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "nimbleutils";
  version = "0.3.1";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "PMunch";
    repo = "nimbleutils";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-/ru8de8t3D5KZ0siiFAB+ak1PgmIBISQhpfczowKe10=";
  };
})
