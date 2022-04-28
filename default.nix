{ pkgs
, ...
}: with pkgs;

let
  bins = [ coreutils gnused dasel ];
in
runCommand "aifd" {
  buildInputs = [ bashInteractive makeWrapper ] ++ bins;
  execPath = "/bin/aifd";
} ''
  mkdir -p $out/bin
  cp ${./aifd} $out/bin/aifd
  wrapProgram $out/bin/aifd --prefix PATH : ${lib.makeBinPath bins}
  patchShebangs $out/bin
''
