{
  fetchFromSourcehut,
  hareHook,
  lib,
  scdoc,
  stdenv,
}:

stdenv.mkDerivation rec {
  pname = "himitsu-ssh";
  version = "0.4";

  src = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "himitsu-ssh";
    rev = "0.4";
    hash = "sha256-/mCyxMDBnJzkVKywmnI4LakpK8Wbj9iYPel13kcJuGU=";
  };

  hare-ssh = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "hare-ssh";
    rev = "0.24.2";
    hash = "sha256-koH/M3Izyjz09SO29TF3+zWIgCxwZn024FDQPSLn1FY=";
  };

  himitsu = fetchFromSourcehut {
    owner = "~sircmpwn";
    repo = "himitsu";
    rev = "0.8";
    hash = "sha256-+GQgRPJut+3zvzSyTGujTbbwJNNgHtFxAoEEwU0lbfU=";
  };

  HAREPATH = "${hare-ssh}:${himitsu}";

  nativeBuildInputs = [
    hareHook
    scdoc
  ];

  installFlags = [ "PREFIX=${builtins.placeholder "out"}" ];

  meta = with lib; {
    homepage = "https://himitsustore.org/";
    description = "SSH integrations for himitsu";
    license = licenses.gpl3Only;
    inherit (hareHook.meta) platforms badPlatforms;
  };
}
