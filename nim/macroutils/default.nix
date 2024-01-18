{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "macroutils";
  version = "1.2.0";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "PMunch";
    repo = "macroutils";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-HGsNbldfhjAEaKsj+DZuMDwhhaLWHlibOWZ3xklKEds=";
  };
})
