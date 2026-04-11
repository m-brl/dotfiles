{ config, inputs, pkgs, ... }:

let
  gemini-cmd = pkgs.writeShellScriptBin "gemini" ''
    export PATH="${pkgs.nodejs_24}/bin:$PATH"
    exec ${pkgs.nodejs_24}/bin/npx @google/gemini-cli "$@"
  '';
in
{
  imports = [
    ./config.d/waybar.nix
    ./config.d/swaync.nix
    ./config.d/swayosd.nix
    ./config.d/hypr/hyprland.nix
    ./config.d/hypr/hyprsunset.nix
    ./config.d/hypr/hypridle.nix
    ./config.d/neovim.nix
    ./config.d/other.nix
  ];

  programs.home-manager.enable = true;

  home.username = "mat";
  home.homeDirectory = "/home/mat";
  home.packages = with pkgs; [
    element-desktop
    qbittorrent
    gemini-cmd
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "m-brl";
        email = "mathieu.borel@epitech.eu";
        signingkey = "93024B9ED648EA50D6FF943836A190C6AEDAE882";
      };
      gpg.program = "/run/current-system/sw/bin/gpg";
      safe.directory = "/etc/nixos";
      core = {
        sshCommand = "ssh -i ~/.ssh/github";
      };
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

#  programs.neovim = {
#    enable = true;
#    extraPackages = [ pkgs.pyright pkgs.nodejs_24 ];
#  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
    };

    sessionVariables = {
      LUCY="$HOME/Projects/eip/lucy";

      PROJECT="$HOME/Projects";
      EIP="$PROJECT/eip/lucy";
      UQAC="$PROJECT/uqac";

      EDITOR="nvim";
      TERMINAL="kitty";

      APPIMAGE_PATH="$HOME/AppImage";
      GOPATH="$HOME/go/bin";
      DOTNET_PATH="$PATH:/home/mat/.dotnet/tools";
      PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:$APPIMAGE_PATH:$VCPKG_ROOT:$GOPATH:$DOTNET_PATH:$PATH";
    };

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      eval "$(direnv hook zsh)"
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = zsh/.;
        file = ".p10k.zsh";
      }
    ];

    syntaxHighlighting.enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  services.protonmail-bridge.enable = true;

  home.stateVersion = "25.05"; 

}
