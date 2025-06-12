{ hostName, username, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    inherit hostName;
  };
  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
