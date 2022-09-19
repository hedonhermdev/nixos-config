{ config, pkgs, ... }:

let 
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
    merge = {
      conflictStyle = "diff3";
      tool          = "vim_mergetool";
    };
    pull.rebase = true;
    push.autoSetupRemote = true;
    url = {
      "https://github.com/".insteadOf = "gh:";
      "ssh://git@github.com".pushInsteadOf = "gh:";
      "https://gitlab.com/".insteadOf = "gl:";
      "ssh://git@gitlab.com".pushInsteadOf = "gl:";
    };
  };
  rg = "${pkgs.ripgrep}/bin/rg";
in {
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    aliases = {
      amend = "commit --amend -m";
      loc = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l; };f";
    };
    userEmail = "jaintirth24@gmail.com";
    userName = "Tirth Jain";
  };
}
