{self, inputs, overlays}:

let
  inherit (self.lib) mkNixpkgs;
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  jovian-nixos = inputs.jovian-nixos;
in {
  nixvm-x86_64 = nixosSystem rec {
    system = "x86_64-linux";
    pkgs = mkNixpkgs { inherit system overlays; };
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ../nixos/machine/vm/x86_64-hardware.nix
      ../nixos/machine/vm/configuration.nix
      ../nixos/ld-patch/x86_64.nix
    ];
  };

  nixvm-aarch64 = nixosSystem rec {
    system = "aarch64-linux";
    pkgs = mkNixpkgs { inherit system overlays; };
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ../nixos/machine/vm/aarch64-hardware.nix
      ../nixos/machine/vm/configuration.nix
      ../nixos/ld-patch/aarch64.nix
    ];
  };

  steam-deck = nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    # pkgs = mkNixpkgs { inherit system overlays; };

    modules = [
      (jovian-nixos + "/modules")
      {
        nixpkgs = {
          config.allowUnfree = true;
          overlays = overlays;
        };
      }
      ../nixos/machine/steamdeck/hardware.nix
      ../nixos/machine/steamdeck/configuration.nix
    ];
  };

  rpi = nixosSystem rec {
    system = "aarch64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      {
        nixpkgs = {
          config.allowUnfree = true;
          overlays = overlays;
        };
      }
      ../nixos/machine/steamdeck/hardware.nix
      ../nixos/machine/steamdeck/configuration.nix
    ];
  };

  hp-pavillion = nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };

    modules = [
      {
        nixpkgs = {
          config = {
            allowUnfree = true;
            # cudaSupport = true;
          };
          overlays = overlays;
        };
      }
      ../nixos/machine/hp-pavillion/hardware.nix
      ../nixos/machine/hp-pavillion/configuration.nix
      ../nixos/machine/hp-pavillion/cachix.nix
    ];
  };

  c220g2 = nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };

    modules = [
      {
        nixpkgs = {
          config.allowUnfree = true;
          overlays = overlays;
        };
      }
      inputs.miniond.nixosModule
      inputs.nix-ld.nixosModules.nix-ld
      ../nixos/machine/c220g2/configuration.nix
      ../nixos/machine/c220g2/binary-cache.nix
      ../nixos/machine/c220g2/boot.nix
      ../nixos/machine/c220g2/devtools.nix
      ../nixos/machine/c220g2/direnv.nix
      ../nixos/machine/c220g2/emulab.nix
      ../nixos/machine/c220g2/hardware-configuration.nix
      ../nixos/machine/c220g2/nix-ld.nix
      ../nixos/machine/c220g2/utilities.nix
    ];
  };
}
