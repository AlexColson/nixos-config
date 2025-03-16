{ username, ... }:
{
  users.users.${username} = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHwFZFjRiXDnmIIi3LCY+h5fttvF9ko29f7Ke/vuw3mM alex.colson@gmail.com"
    ];
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = true;
      UseDns = true;
      PermitRootLogin = "prohibit-password";
    }
  };
}
