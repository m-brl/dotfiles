{
  imports = [
    ./librewolf-bookmarks.nix
  ];

  programs.librewolf = {
    enable = true;
    profiles = {
      mathieu = {
        id = 0;
        isDefault = true;
        path = "mathieu.1";
        extensions.force = true;

        search = {
          default = "Startpage";
        };

        settings = {
        };
      };
    };
  };


  programs.thunderbird = {
    enable = true;
    profiles = {
      mathieu = {
        isDefault = true;
      };
    };
  };

  catppuccin.thunderbird = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
    profile = "mathieu";
  };
}
