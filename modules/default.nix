{ DE, ... }:
{
  imports = [
    #./agenix
    ./apps
    ./core
    ./hardware
    ./${DE}
    ./stylix
    ./virt
    #    ./tailscale
  ];
}
