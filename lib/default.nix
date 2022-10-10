{ nixpkgs, home-manager, neovim-flake, ... }:
{

  mkNixpkgs = system: import nixpkgs {
      inherit system;
      overlays = [
        neovim-flake.overlays.default
      ];
      config = {
        allowUnfree = true;
      };
  };

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
