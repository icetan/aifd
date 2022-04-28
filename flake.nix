{
  description = "aifd - anti import from deriviation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    let
      call = system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        { default = import ./. { inherit pkgs; }; };
    in
    {
      packages = builtins.foldl'
        (acc: system: acc // { ${system} = call system; })
        { }
        [ "aarch64-darwin" "aarch64-linux" "i686-linux" "x86_64-darwin" "x86_64-linux" ];
    };
}
