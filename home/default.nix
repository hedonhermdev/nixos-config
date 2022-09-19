{ config, lib, pkgs, stdenv, ... }:
let
  defaultPkgs = with pkgs; [
   bat
   exa
   fortune
   fzf
   git
   glow
   htop
   httpie
   hyperfine
   neovim
   ngrok
   ranger
   ripgrep
   thefuck
   tldr
   tmux
   wget
   zoxide
  ];
  
  username = "tirth";
  homeDirectory = "/home${username}";
  configHome = "${homeDirectory}/.config";
in {
  programs.home-manager.enable = true;

  imports = (import ./programs);

  home = {
    inherit username homeDirectory;

    stateVersion =  "22.11";

    packages = defaultPkgs;
  };
}
