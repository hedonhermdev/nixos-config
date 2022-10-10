{ self, inputs, ... }:

let
  inherit (self.lib) mkHome mkNixpkgs;
  username = "tirth";
  homeDirectory = "/home/${username}";
in
{
  tirth-x86_64 = let
    system = "x86_64-linux";
  in mkHome rec {
    inherit system username homeDirectory;
    pkgs = mkNixpkgs system;
  };

  tirth-aarch64 = let
    system = "aarch64-linux";
  in mkHome rec {
    inherit system username homeDirectory;
    pkgs = mkNixpkgs system;
  };
}
