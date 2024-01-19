{
  pkgs,
  pkgs-unstable,
  buildNimPackage,
  fetchFromGitHub,
  packages,
  ...
}: let
  pico-sdk151 = with pkgs; (pico-sdk.overrideAttrs (o: rec
    {
      pname = "pico-sdk";
      version = "1.5.1";
      src = fetchFromGitHub {
        fetchSubmodules = true;
        owner = "raspberrypi";
        repo = pname;
        rev = version;
        sha256 = "sha256-GY5jjJzaENL3ftuU5KpEZAmEZgyFRtLwGVg3W1e/4Ho=";
      };
    }));
in
  buildNimPackage (finalAttrs: {
    pname = "piconim";
    version = "0-unstable";
    nimBinOnly = false;

    src = fetchFromGitHub {
      owner = "GarySGlover";
      repo = "nim-picosdk";
      rev = "fa59c71280ed3f4e8695c7be9fe05479f6f64e7d";
      sha256 = "sha256-7vvZ3C1HyfOUsWnIJC/kGHx+791loCyvF4M4dXniXwo=";
    };

    nativeBuildInputs = with packages;
      [
        commandant
        micros
        nimbleutils
        futhark
      ]
      ++ (with pkgs.nimPackages; [
        ])
      ++ (with pkgs; [
        nim
        pico-sdk151
        gnumake
        clang
        libclang
        cmake
        gcc-arm-embedded
      ]);
    buildInputs = with packages;
      [
        commandant
        micros
        nimbleutils
        futhark
      ]
      ++ (with pkgs.nimPackages; [
        ])
      ++ (with pkgs; [
        nim
        pico-sdk151
        gnumake
        clang
        libclang
        cmake
        gcc-arm-embedded
      ]);

    doCheck = false; # Tests faile trying to find opir
  })
