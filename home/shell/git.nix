{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "m-brl";
        email = "103381146+m-brl@users.noreply.github.com";
        signingkey = "~/.ssh/github/github_signin.pub";
      };
      gpg.program = "/run/current-system/sw/bin/gpg";
      gpg.format = "ssh";
      safe.directory = "/etc/nixos";
      commit = {
        gpgsign = "true";
      };
      init = {
        defaultBranch = "master";
      };
      fetch = {
        prune = "yes";
      };
      diff = {
        tool = "vimdiff";
      };
    };
  };
}
