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

    modules = [
      (jovian-nixos + "/modules")
      ../nixos/machine/steamdeck/hardware.nix
      ../nixos/machine/steamdeck/configuration.nix
    ];
  };
}
