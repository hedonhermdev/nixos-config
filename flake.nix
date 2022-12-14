{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    mars-std.url = "github:mars-research/mars-std";
    miniond.url = "github:mars-research/miniond";

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
      url = "github:hedonhermdev/zettl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian-nixos = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      flake = false; 
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-flake, zettl-flake, rust-overlay, nix-ld, jovian-nixos, mars-std, miniond, ... }@inputs: let 
    overlays = [
      neovim-flake.overlays.default
      rust-overlay.overlays.default
      zettl-flake.overlays.default
      mars-std.overlay
    ];
  in {
    lib = import ./lib { inherit inputs; };
    homeConfigurations = import ./outputs/home.nix {
      inherit self inputs overlays;
    };

    nixosConfigurations = (
      import ./outputs/nixos.nix {
        inherit self inputs overlays;
      }
    );
  };
}
