{ pkgs, ... }:
{
  services = {
    #displayManager.sddm.x11.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver.enable = true;
  };

  environment.systemPackages = with pkgs;
  [
    hardinfo2
    kdePackages.skanpage
  ];
  #qt = {
  #  enable = true;
  #  platformTheme = "gnome";
  #  style = "adwaita-dark";
  #};
}
