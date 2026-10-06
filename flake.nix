{
  description = "Home Manager configuration of piri";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-colors,
      ...
    }@raw_inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      inputs = raw_inputs // {
        nix-colors = nix-colors.instantiate { inherit system; };
      };
      mkHome =
        host:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/${host}
            ./home.nix
          ];
          extraSpecialArgs = inputs;
        };
    in
    {
      homeConfigurations."piri@piriT480s" = mkHome "piriT480s";
    };
}
