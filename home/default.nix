{ config, lib, pkgs, stdenv, ... }:
let
  defaultPkgs = with pkgs; [
    bat
    exa
    fd
    fortune
    fzf
    gcc
    gdb
    git
    glow
    htop
    httpie
    hyperfine
    kitty
    ngrok
    nodejs
    nvimPacked
    ranger
    ripgrep
    rnix-lsp
    rust-bin.stable.latest.default
    rust-analyzer
    thefuck
    tldr
    tmux
    wget
    yarn
    zoxide
  ];
in
{
  home = {
    stateVersion = "23.05";

    packages = defaultPkgs;

    shellAliases = {
      "ls" = "exa --icons";
      "cd" = "z";
      "nd" = "nix develop";
      "ns" = "nix-shell";
      "nf" = "nix flake";
      "nfu" = "nix flake update";
      "nfs" = "nix flake show";
      "nr" = "nix repl";
    };

    sessionPath = [ 
      "$HOME/node/bin"
    ];
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
