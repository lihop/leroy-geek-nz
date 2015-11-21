{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7102" }:
with nixpkgs;
let
  backend =
    nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./backend.nix { };
in
stdenv.mkDerivation rec {
  version = "0.1.0.0";
  name = "leroy-geek-nz-${version}";
  src = ./.;

  buildInputs = [
    backend
    cacert
    elmPackages.elm
    ghc
    git
    stack
  ];

  # Required by elm-make. See: https://github.com/elm-lang/elm-make/issues/33
  LANG = "en_US.UTF-8";
  LOCALE_ARCHIVE =
    lib.optionalString stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";

  buildPhase = ''
    export HOME=$TMPDIR
    export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"
    elm-package install -y
    mkdir -p ./static
    for page in ./src/pages/*.elm; do
        filename="''${page##*/}"
        elm-make "''${page}" --output "./static/''${filename%.elm}.html"
    done
  '';

  installPhase = ''
    mkdir -p $out/static
    cp -r ./static/* $out/static
    cp ${backend}/bin/* $out
  '';
}
