{
  description = "Simple flake with crosscompiliable package";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils-cross.url = "github:remimimimimi/flake-utils-cross";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = {
    self,
    flake-utils,
    flake-utils-cross,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem (
      localSystem: let
        mkPkgCross = flake-utils-cross.lib.mkPkgCross {
          inherit nixpkgs localSystem;
          crossSystems = flake-utils.lib.defaultSystems;
        };
      in {
        # To access cross package you need to write packages.<buildPlatform>.<package>.cross.<hostPlatform>
        packages.hello = mkPkgsCross (import ./pkg.nix);
      }
    );
}
