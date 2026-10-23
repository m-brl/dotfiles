{ lib, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.json;
    defaultSopsFormat = "json";
    age.keyFile = lib.mkDefault "/var/lib/sops-nix/keys.txt";

    secrets = {
      "mathieu/password".neededForUsers = true;
      "mathieu/CLAUDE_CODE_OAUTH_TOKEN" = { owner = "mathieu"; mode = "0400"; };
      "mathieu/GH_TOKEN" = { owner = "mathieu"; mode = "0400"; };
    };
  };
}
