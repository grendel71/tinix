 { stdenv, lib
, fetchurl
, openssl
, zlib
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "ti-tools";
  version = "0.2.0";
  version2 = "24";

  src = fetchurl {
    #https://github.com/cqb13/ti-tools/releases/download/release-0.2.0-24/ti-tools-0.2.0-x86_64-unknown-linux-musl.tar.gz
    url = "https://github.com/cqb13/ti-tools/releases/download/release-${version}-${version2}/ti-tools-${version}-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-8J1Kne8smWAnuHi2cDZA9vayxa/m+RAQDBF6TiMo2Nc=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    
    openssl
    zlib
    #pulseaudio
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D ti-tools $out/bin/ti-tools
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/cqb13/ti-tools";
    description = "tilp tools";
    platforms = platforms.linux;
  };
}