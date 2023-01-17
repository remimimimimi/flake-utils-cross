{
  description = "Flake utils for packages cross compilation";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    flake-utils,
  }: {
    lib = import ./. {inherit flake-utils;};
    templates = {
      mkPkgCross = {
        path = ./templates/mkPkgCross;
        description = "Simple flake with crosscompiliable package";
      };
    };
  };
}
