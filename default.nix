{ lib, writeShellScriptBin
, coreutils, findutils, gnused, dasel, bash
}:

let
  bins = [ coreutils findutils gnused dasel bash ];
in
(writeShellScriptBin "aifd" ''
  PATH="${lib.makeBinPath bins}:''${PATH:+:$PATH}"
  ${builtins.readFile ./aifd}
'').overrideAttrs (old: {
  buildInputs = (old.buildInputs or []) ++ bins;
})
