{ self, inputs, pkgs, ... }:

let
  inherit (self.lib) mkHome;

in
{
  tirth-nixvm = mkHome rec {
    inherit pkgs;
    system = "x86_64-linux"; 
    username = "tirth";
    homeDirectory = "/home/${username}";
  };
}
