{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = import ./lib {
        inherit nixpkgs pkgs inputs home-manager; 
      };

    in {
      homeConfigurations = (
        import ./outputs/home.nix {
          inherit inputs system;
        }
      );

      nixosConfigurations = (
        import ./outputs/nixos.nix {
          inherit inputs system;
        }
      );
    };
}
