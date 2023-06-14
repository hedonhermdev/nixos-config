{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.pathsToLink = [ "/libexec" ];

  networking.hostName = "hp-pavillion"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 3000 ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

  };


  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

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

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "tirth";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.lidSwitchDocked = "ignore";


  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "SourceCodePro" ]; })
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  programs.zsh.enable = true;

  services.tailscale.enable = true;

  services.hydra = {
    enable = true;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [ ];
    useSubstitutes = true;
  };

  # enable flakes support
  nix.settings = {
    substituters = [ "https://cache.garnix.io" ];
    trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "tirth" ];
  };

  system.stateVersion = "23.05";
}

