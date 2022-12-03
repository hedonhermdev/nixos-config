{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [
      "nixpkgs=${pkgs.path}"
    ];
  };

  nixpkgs.overlays = [
    (self: super: {
      nixos-rebuild = super.nixos-rebuild.overrideAttrs (old: {
      	postInstall = ''
          patch $out/bin/nixos-rebuild ${./patches/nixos-rebuild.patch}
	'';
      });
    })
  ];

  networking.useDHCP = true;
  networking.hostName = "";
  networking.firewall.enable = false;

  services.openssh.enable = true;
  
  environment.systemPackages = with pkgs; [
    home-manager # user packages are installed with home-brew
    mosh # ssh replacement
  ];

  programs.mosh.enable = true; # start mosh server

  programs.git.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "21.11";
}
