{ username, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since -15d --keep 20";
    flake = "/home/${username}/dev/nixos/nixos-config";
  };
}
