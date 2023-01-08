{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steamdeck";
  networking.networkmanager.enable = true;

  system.autoUpgrade.channel = "https://nixos.org/channels/unstable/";

  services.xserver.enable = true;

  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.lightdm.enable = false;

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
        extraGroups = [ "wheel" "networkmanager" ]; home = "/home/tirth";
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
  jovian.devices.steamdeck.enableVendorRadv = false;

  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  services.tailscale.enable = true;

  # enable flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.services.gamescope-switcher = {
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      User = 1000;
      PAMName = "login";
      WorkingDirectory = "~";

      TTYPath = "/dev/tty7";
      TTYReset = "yes";
      TTYVHangup = "yes";
      TTYVTDisallocate = "yes";

      StandardInput = "tty-fail";
      StandardOutput = "journal";
      StandardError = "journal";

      UtmpIdentifier = "tty7";
      UtmpMode = "user";

      Restart = "always";

      SupplementaryGroups = "video";
    };

    script = ''
      export PATH=${lib.makeBinPath [ pkgs.libsForQt5.plasma5.plasma-workspace pkgs.xorg.xinit ]}:$PATH
      #echo $PATH >>~/meow
      #exec startx >>~/meow 2>&1
      #exec startplasma-wayland¸

      set-session () {
        mkdir -p ~/.local/state
        >~/.local/state/steamos-session-select echo "$1"
      }
      consume-session () {
        if [[ -e ~/.local/state/steamos-session-select ]]; then
          cat ~/.local/state/steamos-session-select
          rm ~/.local/state/steamos-session-select
        else
          echo "gamescope"
        fi
      }
      while :; do
        session=$(consume-session)
        echo "Starting $session" >> ~/meow
        case "$session" in
          plasma)
            # FIXME: Replace with your favorite method
            startx
            ;;
          gamescope)
            steam-session
            ;;
        esac
      done
    '';
  };

  system.stateVersion = "22.11"; # Did you read the comment?
}
