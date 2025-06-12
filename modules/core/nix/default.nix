{ pkgs, lib, username, ... }:
{
  imports = [ ./nh ];

  # https://github.com/lovesegfault/nix-config/blob/e412cd01cda084c7e3f5c1fbcf7d99665999949e/core/nixos.nix#L39
  system = {
    extraSystemBuilderCmds = ''
      ln -sv ${pkgs.path} $out/nixpkgs
    '';
    stateVersion = "25.05";
  };

  # Enable Flakes and nix-commands, enable removing channels
  nix = {
    nixPath = [ "nixpkgs=/run/current-system/nixpkgs" ];
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    users.${username} = {
      # The home.stateVersion option does not have a default and must be set
      home.stateVersion = "25.05";
      nixpkgs.config.allowUnfree = true;
      home.file = {
        ".gitconfig".text = ''
          [user]
            name = "Alex Colson"
            email = alex.colson@gmail.com	

          [gpg]
            format = ssh
        '';
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.printing = {
    enable = true;
    listenAddresses = [ "*:631" ];
    allowFrom = [ "all" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };

  hardware = 
    let 
      brother = "Brother_MFC-L2710DW";
      hostName = "192.168.0.224";
    in 
    {
      printers = {
        ensureDefaultPrinter = brother;
        ensurePrinters = [
        {
          name = brother;
          deviceUri = "ipp://${hostName}/ipp";
          model = "everywhere";
          description = lib.replaceStrings [ "_" ] [ " " ] brother;
          location = "Study";
        }
      ];  
      };
      sane.enable= true;
    };

  system.autoUpgrade = {
      enable = true;
      dates = "daily";
      flake = "/home/${username}/dev/nixos/nixos-config";
      flags = [
          "--update-input" "nixpkgs"
      ];
      allowReboot = true;
      rebootWindow = {
        lower = "01:00";
        upper = "05:00";
      };
  };
  
  environment.systemPackages = with pkgs; [
    vim
    neovim
    tmux
    btop
    git
    wget
    curl
    ninja
    cmake
    gcc14
    clang_19
    hplipWithPlugin
  ];
}
