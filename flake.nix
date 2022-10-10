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

  outputs = { self, nixpkgs, home-manager, neovim-flake, ... }@inputs: {
    lib = import ./lib inputs;
    homeConfigurations = import ./outputs/home.nix {
      inherit self inputs nixpkgs;
    };

    nixosConfigurations = (
      import ./outputs/nixos.nix {
        inherit inputs;
      }
    );
  };
}
