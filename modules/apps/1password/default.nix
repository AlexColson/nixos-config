{ username, ... }:
{
  home-manager.users.${username} = {
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
}
