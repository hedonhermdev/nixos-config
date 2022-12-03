{ self, inputs, overlays, ... }:

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
    pkgs = mkNixpkgs { inherit system overlays; };
  };

  tirth-aarch64 = let
    system = "aarch64-linux";
  in mkHome rec {
    inherit system username homeDirectory;
    pkgs = mkNixpkgs { inherit system overlays; };
  };

  xiangd-aarch64 = let
    system = "aarch64-linux";
    username = "xiangd";
    homeDirectory = "/home/xiang";
  in mkHome rec {
    inherit system username homeDirectory;
    pkgs = mkNixpkgs { inherit system overlays; };
  };

  tirthj-c220g2 = let
    system = "x86_64-linux";
    username = "tirthj";
    homeDirectory = "/users/tirthj";
  in mkHome rec {
    inherit system username homeDirectory;
    pkgs = mkNixpkgs { inherit system overlays; };
  };
}
