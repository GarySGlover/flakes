{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "micros";
  version = "0.1.15";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "beef331";
    repo = "micros";
    rev = "v${finalAttrs.version}";
    sha256 = "sha256-ATOW93ecVl0axLDsVAx5xVtfx7QOuzxYvst5bU2+LNg=";
  };

  doCheck = false; # TODO Check failing tests
})
