{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      url = github:hedonhermdev/neovim-flake;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, neovim-flake, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;

	overlays = [
	  neovim-flake.overlays.default
	];
      };

    in {
      lib = import ./lib inputs;
      homeConfigurations = import ./outputs/home.nix {
        inherit self inputs pkgs;
      };

      nixosConfigurations = (
        import ./outputs/nixos.nix {
          inherit inputs system;
        }
      );
    };
}
