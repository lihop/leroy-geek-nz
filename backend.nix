{ mkDerivation, base, scotty, stdenv, wai-extra
, wai-middleware-static
}:
mkDerivation {
  pname = "leroy-geek-nz";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base scotty wai-extra wai-middleware-static
  ];
  homepage = "http://github.com/lihop/leroy-geek-nz#readme";
  description = "Personal website of Leroy Hopson";
  license = stdenv.lib.licenses.bsd3;
}
