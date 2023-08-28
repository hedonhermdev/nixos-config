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
    graphviz
    glow
    htop
    httpie
    hyperfine
    imgcat
    jq
    kitty
    libiconv
    librsvg
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
      "itrans" = "sed  '/bgcolor=/s/\(bgcolor=\)\".*\"/\1\"transparent\"/; t; /}/{N;N;s/}/bgcolor=\"transparent\";\n}/;}'";
      "idot" = "${pkgs.graphviz}/bin/dot -Tsvg";
      "isvg" = "${pkgs.librsvg}/bin/rsvg-convert | ${pkgs.imgcat}/bin/imgcat";
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
