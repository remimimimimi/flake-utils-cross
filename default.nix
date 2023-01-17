{flake-utils}: {
  mkPkgCross = {
    nixpkgs,
    localSystem,
    crossSystems,
  }: pkg: let
    overlay = final: prev: {
      crossPkg = prev.callPackage pkg {};
    };
    crossSystems' = builtins.filter (system: system != localSystem) crossSystems;
  in
    ((import nixpkgs {inherit localSystem;}).callPackage pkg {})
    // (
      flake-utils.lib.eachSystem crossSystems'
      (
        targetSystem: {
          cross =
            (import nixpkgs {
              inherit localSystem;
              crossSystem = targetSystem;
              overlay = [overlay];
              crossOverlays = [overlay];
            })
            .crossPkg;
        }
      )
    );
}
