{ ... }:

{
  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
    git.enable = true;

    nh = {
      enable = true;

      flake = "/etc/nixos";

      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 7d --keep 5";
      };
    };
  };
}
