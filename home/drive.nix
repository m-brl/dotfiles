{ inputs, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rclone fuse3
  ];


}
