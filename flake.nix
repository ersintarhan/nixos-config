{
  description = "Ersin's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      catppuccin,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        bosgame = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/bosgame
            sops-nix.nixosModules.sops
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ersin = import ./home/ersin;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
                catppuccin.homeModules.catppuccin
              ];
              home-manager.extraSpecialArgs = { inherit inputs; hostname = "bosgame"; };
            }
          ];
        };

        ryzen = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/ryzen
            sops-nix.nixosModules.sops
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ersin = import ./home/ersin;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
                catppuccin.homeModules.catppuccin
              ];
              home-manager.extraSpecialArgs = { inherit inputs; hostname = "ryzen"; };
            }
          ];
        };
      };
    };
}
