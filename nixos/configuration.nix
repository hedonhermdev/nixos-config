{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use unstable channel
  system.autoUpgrade.channel = "https://nixos.org/channels/unstable/";

  # enable ssh server
  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
  };

  # create new user for myself
  users = {
    # everyone uses zsh
    defaultUserShell = pkgs.zsh;
    users = {
      "tirth" = {
        group = "users";
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        home = "/home/tirth";
        openssh.authorizedKeys.keyFiles = [
          ./ssh/authorized_keys
        ];
      };
      "xiangd" = {
        group = "users";
        isNormalUser = true;
        home = "/home/xiangd";
        openssh.authorizedKeys.keyFiles = [
          ./ssh/authorized_keys
        ];
      };
    };
  };

  # dont require sudo for myself
  security.sudo.extraRules = [
    {
      users = [ "tirth" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }
  ];

  # enable vim system-wide
  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  services.tailscale.enable = true;

  services.spice-vdagentd.enable = true;

  # enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
