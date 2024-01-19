{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "commandant";
  version = "0.15-unstable";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "casey-SK";
    repo = "commandant";
    rev = "492ae9442e5e2c5948df31b6f065b8fa70c01308";
    sha256 = "sha256-nKuW83jrIaShpd9pu6NO/upkI9TfrG8RTM/uT0UAEKc=";
  };
})
