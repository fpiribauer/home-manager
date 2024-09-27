{
  description = "Home Manager configuration of piri";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-23-11.url = "github:nixos/nixpkgs/23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:fpiribauer/dotfiles";
      flake = false;
    };
    schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    nix-colors = {
      url = "github:fpiribauer/nix-colors/base24";
      inputs.schemes.follows = "schemes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-23-11,
      home-manager,
      nix-colors,
      ...
    }@raw_inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "${system}";
        config = {
          allowUnfree = true;
        };
      };
      pkgs-23-11 = import nixpkgs-23-11 {
        system = "${system}";
        config = {
          allowUnfree = true;
        };
      };
      inputs = raw_inputs // {
        inherit pkgs pkgs-23-11;
        unstablePkgs = pkgs;
        nix-colors = nix-colors.instantiate { inherit system; };
      };
      private-config = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/T480piri
          ./home.nix
        ];
        extraSpecialArgs = inputs;
      };
      work-config = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./hosts/piribauer-laptop
          ./home.nix
        ];
        extraSpecialArgs = inputs;
      };
    in
    {
      homeConfigurations."piri@T480piri" = private-config;
      homeConfigurations."fpiribauer@piribauer-laptop" = work-config;
      tests = import ./tests (inputs // private-config);
    };
}
