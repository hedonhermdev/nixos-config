{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    neovim-flake = {
      url = github:hedonhermdev/neovim-flake;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zettl-flake = {
      url = github:hedonhermdev/zettl;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-flake, zettl-flake, rust-overlay, ... }@inputs: let 
    overlays = [
      neovim-flake.overlays.default
      rust-overlay.overlays.default
      zettl-flake.overlays.default
    ];
  in {
    lib = import ./lib { inherit inputs; };
    homeConfigurations = import ./outputs/home.nix {
      inherit self inputs overlays;
    };

    nixosConfigurations = (
      import ./outputs/nixos.nix {
        inherit inputs;
      }
    );
  };
}
