{ ... }:

{
  services.snapper = {
    configs."persist" = {
      FSTYPE = "btrfs";
      SUBVOLUME = "/persist";
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_LIMIT_HOURLY = 24;
      TIMELINE_LIMIT_DAILY = 7;
      TIMELINE_LIMIT_WEEKLY = 4;
      TIMELINE_LIMIT_MONTHLY = 3;
      TIMELINE_LIMIT_YEARLY = 0;
    };
  };

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
      "/var/lib/systemd/pstore"
      "/var/lib/systemd/backlight"
      "/var/lib/fprint"
      "/var/lib/fwupd"
      "/var/lib/sddm"
      "/var/lib/cups"
      "/var/lib/libvirt"
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
        ".local/share/newsboat"
        ".local/share/pki"
        ".local/share/zoxide"

        ".local/state/wireplumber"
      ];
    };
  };

  environment.persistence."/nosnap" = {
    hideMounts = true;

    directories = [
      "/var/lib/libvirt/images"
      "/var/lib/containers"
      "/var/lib/private/ollama/models"
    ];

    users.mathieu.directories = [
      ".local/share/Steam"
    ];
  };
}
