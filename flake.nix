{
  description = "Home Manager configuration of piri";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfiles = {
      url = "github:fpiribauer/dotfiles";
      flake = false;
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, dotfiles, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "${system}"; config = { allowUnfree = true; }; };
    in {
      homeConfigurations."piri" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = inputs // { unstablePkgs=pkgs; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
