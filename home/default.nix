{ lib, hasGui, pkgs, ... }:
let
  defaultPkgs = with pkgs; [
    bat
    exa
    fd
    fortune
    fzf
    gcc
    git
    glow
    htop
    httpie
    hyperfine
    kitty
    libiconv
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
  ] ++ (if hasGui then with pkgs; [
    firefox-bin
  ] else [ ]);
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

    sessionVariables.LIBRARY_PATH = ''${lib.makeLibraryPath [pkgs.libiconv]}''${LIBRARY_PATH:+:$LIBRARY_PATH}'';
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
