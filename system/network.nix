{ config, pkgs, ... }:

{
  networking = {
    hostName = "mathieu-workstation";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
    };

    hosts = {
      "100.64.0.11" = [ "lucy_jetson.local" "lcp.local" "lucy_control_panel.local" ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

}
