{ inputs, ... }:

with inputs;
{

  mkNixpkgs = { system, overlays }: import nixpkgs {
    inherit system overlays;
    config = {
      allowUnfree = true;
    };
  };

  mkHome = { pkgs, system, hasGui ? false, username, homeDirectory }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
      modules = [
        (import ../home { 
          inherit pkgs hasGui;
          lib = pkgs.lib;
        })
        zettl-flake.nixosModules."${system}".hm
        {
          home = { inherit username homeDirectory; };
        }
      ];
    }
  );
}
