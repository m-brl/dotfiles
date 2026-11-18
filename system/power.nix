{ ... }:

{
  imports = [
    ./polkit/fan.nix
  ];

  services = {
    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 81;
      };
    };

    upower = {
      enable = true;
    };

    thinkfan = {
      enable = true;
      smartSupport = true;
    };
  };
}
