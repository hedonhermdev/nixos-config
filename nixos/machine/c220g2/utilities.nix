# Utilities

{ pkgs, ... }:
{
  programs.tmux.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mars-research.mars-tools

    file
    wget
    curl
    pv

    git
    git-crypt

    libarchive
    p7zip

    usbutils
    pciutils

    iotop
    iftop
    htop

    alacritty.terminfo
    kitty.terminfo

    # misc - keep alphabetically sorted
    cachix
    lm_sensors
    msr-tools
    ripgrep
  ];
}
