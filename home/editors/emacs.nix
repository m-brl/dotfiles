{ lib, config, pkgs, inputs, ... }:

{
  imports = [

  ];

  programs.emacs = {
    enable = true;

    package = pkgs.emacs-pgtk;
  };

}
