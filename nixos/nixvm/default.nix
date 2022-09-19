{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

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
    vim
    home-manager
  ];

  # enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
