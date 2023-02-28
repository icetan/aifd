{
  description = "aifd - anti import from deriviation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    src-block.url = "github:icetan/src-block";
    src-block.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    let
      call = pkgs: pkgs.callPackage ./. { };

      perSystem = system:
        let
          pkgs = import nixpkgs { inherit system; };
          aifd = call pkgs;
        in
        {
          inherit aifd;
          default = aifd;
        };

      packages = builtins.foldl'
        (acc: system: acc // { ${system} = perSystem system; })
        { }
        [ "aarch64-darwin" "aarch64-linux" "i686-linux" "x86_64-darwin" "x86_64-linux" ];

      overlay = final: prev: { aifd = call prev; };
    in
    {
      inherit packages;
      overlays.default = overlay;
    };
}
