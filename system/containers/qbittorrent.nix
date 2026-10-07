{ config, pkgs, ... }:

{
    containers.qbittorrent = {
        autoStart = true;
        privateNetwork = true;
        hostAddress = "192.168.100.1";
        localAddress = "192.168.100.2";

        allowedDevices = [ { node = "/dev/net/tun"; modifier = "rw"; } ];

        bindMounts = {
            "/etc/wireguard" = {
                hostPath= "/etc/wireguard";
                isReadOnly = true;
            };
            "/data" = {
                hostPath = "/mnt/data";
                isReadOnly = false;
            };
        };

        config = { config, pkgs, ... }: {
            boot.specialFileSystems."/dev/net/tun" = {
                device = "/dev/net/tun";
                fsType = "none";
                options = [ "bind" ];
            };
            networking.nameservers = [ "1.1.1.1" "9.9.9.9" ];
            networking.wg-quick.interfaces.wg0 = {
                configFile = "/etc/wireguard/protonvpn.conf";
            };

            services.qbittorrent = {
                enable = true;
                webuiPort = 8080;
            };

            networking.firewall.allowedTCPPorts = [ 8080 ];
        };
    };
}
