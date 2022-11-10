{inputs}:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in {
  nixvm-x86_64 = nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ../nixos/machine/nixvm-x86_64.nix
      ../nixos/configuration.nix
    ];
  };

  nixvm-aarch64 = nixosSystem {
    system = "aarch64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ../nixos/machine/nixvm-aarch64.nix
      ../nixos/configuration.nix
      ../nixos/ld-patch.nix
    ];
  };
}
