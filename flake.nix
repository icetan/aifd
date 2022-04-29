{
  description = "aifd - anti import from deriviation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    src-block.url = "github:icetan/src-block";
    src-block.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    let
      overlay = final: prev: {
        aifd = import ./. { pkgs = prev; };
      };

      call = system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        rec {
          aifd = import ./. { inherit pkgs; };
          default = aifd;
        };

      packages = builtins.foldl'
        (acc: system: acc // { ${system} = call system; })
        { }
        [ "aarch64-darwin" "aarch64-linux" "i686-linux" "x86_64-darwin" "x86_64-linux" ];
    in
    {
      inherit packages;
      overlays.default = overlay;
    };
}
