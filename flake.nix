{
  description = "Home Manager configuration of ubuntu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs"; # optional, not necessary for the module
    };
  };
    outputs = {
      self,
      nixpkgs,
      home-manager,
      vscode-server,
      nix-vscode-extensions,
      ...
    } @ inputs: let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      systems = ["x86_64-linux"];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      pkgs = nixpkgs.legacyPackages.${system}; # for home manager
    in {
      homeConfigurations."ubuntu" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home.nix ];
      };
    };
}
