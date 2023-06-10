{ inputs, ... }:

with inputs;
{

  mkNixpkgs = { system, overlays }: import nixpkgs {
    inherit system overlays;
    config = {
      allowUnfree = true;
    };
  };

  mkHome = { pkgs, system, username, homeDirectory }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
      modules = [
        ../home
        zettl-flake.nixosModules."${system}".hm
        {
          home = { inherit username homeDirectory; };
        }
      ];
    }
  );
}
