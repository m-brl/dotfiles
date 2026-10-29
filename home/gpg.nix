{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    extraConfig = ''
        allow-preset-passphrase
    '';
  };

  programs.gpg = {
    enable = true;
  };

  home.packages = [
    pkgs.pinentry-qt
  ];

  home.file.".pam-gnupg".text = ''
    ED424471D106A802D9AFD45597A5DEAB07862725
    5E23D88E160163F2D779FBBC7986690181564189
  '';
}
