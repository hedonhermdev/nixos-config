{inputs, system}:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in {
  nixvm = nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ../nixos/nixvm
    ];
  };
}
