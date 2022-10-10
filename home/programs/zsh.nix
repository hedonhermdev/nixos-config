{ config, pkgs, lib, ... }:

with lib;

{
  programs.zsh = {
    enable = true;
    autocd = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = ".p10k.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "fzf" "thefuck" "git" "history-substring-search" ];
      theme = "robbyrussell";
    };

    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      eval "$(${pkgs.zoxide} init zsh)"
    '';
  };
}
