# Dev tools
#
# A small set of dev tools for convenience. For projects you should pin
# the dependencies with a flake.
#
# You can create one by running:
#    mars init

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
  ];
}
