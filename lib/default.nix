{ nixpkgs, home-manager, ... }:
{
  mkHome = { pkgs, system, username, homeDirectory }: (
    home-manager.lib.homeManagerConfiguration rec {
      inherit pkgs;
      modules = [
        ../home
        {
          home = { inherit username homeDirectory; };
        }
      ];
    }
  );
}
