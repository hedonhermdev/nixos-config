{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    mars-std.url = "github:mars-research/mars-std";

    miniond.url = "github:mars-research/miniond";

    attic = {
      url = github:zhaofengli/attic;
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { self, nixpkgs, home-manager, attic, neovim-flake, zettl-flake, rust-overlay, nix-ld, jovian-nixos, mars-std, miniond, ... }@inputs:
    let
      overlays = [
        neovim-flake.overlays.default
        rust-overlay.overlays.default
        zettl-flake.overlays.default
        mars-std.overlay
        attic.overlays.default
      ];

      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    in
    {
      lib = import ./lib { inherit inputs; };


      homeConfigurations = import ./outputs/home.nix {
        inherit self inputs overlays;
      };

      nixosConfigurations = import ./outputs/nixos.nix {
        inherit self inputs overlays;
      }
      ;
    } // mars-std.lib.eachSystem supportedSystems (system: {
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
    });

}
