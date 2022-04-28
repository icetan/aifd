{ pkgs
, ...
}: with pkgs;

runCommand "aifd" {
  buildInputs = [ bashInteractive makeWrapper  ];
  execPath = "/bin/aifd";
} ''
  mkdir -p $out/bin
  cp ${./aifd} $out/bin/aifd
  wrapProgram $out/bin/aifd --prefix PATH : ${lib.makeBinPath [
    coreutils gnused dasel
  ]}
  patchShebangs $out/bin
''
