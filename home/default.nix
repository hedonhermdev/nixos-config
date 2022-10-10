{ config, lib, pkgs, stdenv, ... }:
let
  defaultPkgs = with pkgs; [
  bat
  cargo
  exa
  fortune
  fzf
  git
  glow
  htop
  httpie
  hyperfine
  ngrok
  nodejs
  nvimPacked
  ranger
  ripgrep
  rustc
  rust-analyzer
  thefuck
  tldr
  tmux
  wget
  zoxide
  ];
  
in {
  home = {
    stateVersion =  "22.11";

    packages = defaultPkgs;

    shellAliases = {
      ls = "exa --icons";
      "ls -l" = "exa --icons --long --header --git";
      "ls -x" = "exa --icons --long --extended";
      "cd" = "z";
    };
  };
  
  programs = {
    home-manager = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };

  imports = (import ./programs);

}
