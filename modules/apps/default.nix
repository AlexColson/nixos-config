{ pkgs, username, ... }:
{
  imports = [
    ./jetbrains
    # ./libreoffice
    ./obsidian
    ./vscode
    ./gaming
  ];
  environment.systemPackages = with pkgs; [
    spotify
  ];
  home-manager.users.${username} = {
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
    };
    home.packages = with pkgs; [
      discord
      dropbox
      keepassxc
      #variety # wallpaper manager
      #microsoft-edge
      #ticktick
      #remmina
      #openvpn
      #vivaldi
      # vscode
    ];

    programs.zathura = {
      enable = true;
    };

  };
}
