{ config, pkgs, ... }:

{
  system.autoUpgrade.channel = "https://nixos.org/channels/unstable/";

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "raspberrypi";
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users = {
    # everyone uses zsh
    defaultUserShell = pkgs.zsh;
    users = {
      "tirth" = {
        group = "users";
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
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


  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  services.tailscale.enable = true;

  # enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "21.03";

}

