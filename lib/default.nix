{ nixpkgs, pkgs, inputs, home-manager, ... }:
{
  inherit pkgs;
  mkHome = {
      username,
      homeDirectory,
      configHome,
    }:
    home-manager.lib.homeManagerConfiguration {
      modules = [
        import ../home/home.nix
      ];
      inherit pkgs;
      extraSpecialArgs = {
        inherit username homeDirectory configHome;
      };
  };
}
