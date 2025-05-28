{ pkgs, ... }:
{
  # Proton Experimental is pretty sweet
  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable =true;
    gamemode.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
    protonup
  ];

}
