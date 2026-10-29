{ pkgs, ... }:

{
  imports = [
    ./editors
    ./shell
    ./gpg.nix
    ./programs/cli.nix
  ];

  home.username = "mathieu";
  home.homeDirectory = "/home/mathieu";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Dev
    devenv
    vectorcode
    clang cmake pkg-config gnumake ninja cgdb gdb valgrind
    patchelf
    uv pixi
    python314
    ed
    fzf

    # Tools
    rclone rsync
    zip unzip ripgrep fd
  ];
}
