{ ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" ];

    # Prebuilt CUDA packages (ollama-cuda, btop with cudaSupport, ...) are unfree and
    # not on cache.nixos.org. https://wiki.nixos.org/wiki/CUDA
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };

  # Periodic hard-link deduplication of /nix/store (cheaper than auto-optimise-store,
  # which slows down every build).
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
