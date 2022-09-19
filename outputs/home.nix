{ inputs, system, ... }:

with inputs;

let
  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  mkHome = { username }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;

      modules = [
        ../home
      ];
    }
  );
in
{
  tirth = mkHome { username = "tirth"; };
}
