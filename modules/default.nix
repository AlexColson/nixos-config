{ DE, ... }:
{
  imports = [
    #./agenix
    ./apps
    ./core
    ./hardware
    ./${DE}
    #./hyprland
    ./stylix
    ./virt
    #    ./tailscale
  ];
}
