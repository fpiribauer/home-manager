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
      url = "github:Zh40Le1ZOOB/nix-colors";
      inputs.schemes.follows = "schemes";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-23-11, home-manager, dotfiles, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "${system}"; config = { allowUnfree = true; }; };
      pkgs-23-11 = import nixpkgs-23-11 { system = "${system}"; config = { allowUnfree = true; }; };
      home-manager-config = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = inputs // { unstablePkgs=pkgs; inherit pkgs-23-11; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    in {
      homeConfigurations."piri" = home-manager-config;
      tests = import ./tests (inputs // home-manager-config);
    };
}
