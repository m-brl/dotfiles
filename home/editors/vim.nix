{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    extraConfig = ''
      set hlsearch
      set number
      set autoindent
      set expandtab
      set shiftwidth=4
      set tabstop=4
    '';
  };
}
