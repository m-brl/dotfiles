{ config, pkgs, inputs, ... }:

{
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"

      "/var/log"

      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/sops-nix"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      "/var/lib/tailscale"
      "/var/lib/vnstat"
      "/var/lib/systemd/timers"
      "/var/lib/fprint"
      "/var/lib/private"
      "/var/lib/sddm"
      "/var/lib/cups"
      "/var/lib/libvirt"
      "/var/lib/containers"
      "/var/lib/tor"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/var/lib/systemd/credential.secret"
    ];

    users.mathieu = {
      directories = [
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".password-store"; mode = "0700"; }

        "Maildir"
        "Projects"
        "Documents"
        "Pictures"
        "Videos"

        ".claude"
        ".librewolf"

        ".config/vesktop"
        ".config/protonmail"
        ".config/github-copilot"

        ".local/share/atuin"
        ".local/share/direnv"
        ".local/share/keyrings"
        ".local/share/protonmail"
        ".local/share/pki"
        ".local/share/Steam"
        ".local/share/zoxide"
      ];
    };
  };
}
