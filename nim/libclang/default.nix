{
  buildNimPackage,
  fetchFromGitHub,
  ...
}:
buildNimPackage (finalAttrs: {
  pname = "libclang";
  version = "0.59-unstable";
  nimBinOnly = false;

  src = fetchFromGitHub {
    owner = "PMunch";
    repo = "libclang-nim";
    rev = "14594ef3cee63a2f936f83799a6726a3d77264e8";
    sha256 = "sha256-SXsD/sKyfWM+XK4KgXlKiknqZT7vHREpU46z6TKfek0=";
  };
})
