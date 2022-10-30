{ config, pkgs, ... }:
{
  programs.zettl = {
    enable = true;

    settings = {
      zettl = {
        zettlDir = "${config.home.homeDirectory}/kasten";
        editorCmd = "${pkgs.nvimPacked}/bin/nvim";
        author = "Tirth Jain";
        name = "zettelkasten";
      };
    };

  };

}
