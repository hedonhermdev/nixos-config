{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steamdeck";
  networking.networkmanager.enable = true;

  system.autoUpgrade.channel = "https://nixos.org/channels/unstable/";

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # enable openssh
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

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
          ../../ssh/authorized_keys
        ];
      };
    };
  };

  security.sudo.extraRules = [
    {
      users = [ "tirth" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }
  ];

  # enable steam 
  jovian.devices.steamdeck.enable = true;
  jovian.steam.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  services.tailscale.enable = true;

  # enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "22.11"; # Did you read the comment?
}
