{ pkgs }:

{
  wrapSecrets = import ./wrap-secrets.nix { inherit pkgs; };
}
