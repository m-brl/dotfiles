{ pkgs }:

{
  wrapSecrets = import ./wrap-secrets.nix { inherit pkgs; };
  wrapKeyring = import ./wrap-keyring.nix { inherit pkgs; };
}
