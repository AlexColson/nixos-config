{
  description = "Alex Colson's machine specific configuration flake.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # when using a stable version of nixos, we need to use a matching version
    # of stylix. Following nixpkgs isn't enough
    stylix.url = "github:nix-community/stylix/release-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix = {
    #   url = "github:ryantm/agenix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.darwin.follows = "";
    # };

    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # };

    # hyprlock = {
    #   url = "github:hyprwm/hyprlock";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # hyprpicker = {
    #   url = "github:hyprwm/hyprpicker";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # NixOS-WSL = {
    #   url = "github:nix-community/NixOS-WSL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs =
    { self, nixpkgs, ... }@attrs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {

      nixosConfigurations = {

        # live-image =
        #   let
        #     system = "x86_64-linux";
        #   in
        #   nixpkgs.lib.nixosSystem {
        #     inherit system;
        #     specialArgs = {
        #       username = "nixos";
        #       hostName = "live-image";
        #       hyprlandConfig = "laptop";
        #       inherit system;
        #     } // attrs;
        #     modules = [ ./minimal.nix ];
        #   }; # live-image

# Appended new system
	bigrawr =
       	let system = "x86_64-linux";
	in nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "alex";
	    DE = "plasma";
            hostName = "bigrawr";
            hyprlandConfig = "desktop";
	    inherit system;
          } // attrs;        
          modules = [
            ./.
          ];
        }; # bigrawr
      }; # configurations

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixfmt-classic
              statix
            ];
          };
        }
      );

      templates.default = {
        path = ./.;
        description = "The default template for Alex Colson's nixflakes.";
      }; # templates

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
