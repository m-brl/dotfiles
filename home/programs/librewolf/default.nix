{ inputs, config, lib, pkgs, ... }:

let
  jail = inputs.jail-nix.lib.init pkgs;

  librewolf-jailed =
    jail "librewolf" config.programs.librewolf.finalPackage
      (with jail.combinators; [
        network
        gui
        gpu
        pipewire

        (readonly "/nix/store")
        (readwrite (noescape "~/.librewolf"))
        (readwrite (noescape "~/.cache/librewolf"))
        (readwrite (noescape "~/Downloads"))
      ]);

  commonSearch = {
    default = "startpage";
    privateDefault = "startpage";
    force = true;

    engines = {
      "startpage" = {
        name = "Startpage";
        urls = [{
          template = "https://www.startpage.com/sp/search";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        icon = "https://www.startpage.com/favicon.ico";
        definedAliases = [ "@sp" "@startpage" ];
      };

      "google" = {
        name = "Google";
        urls = [{
          template = "https://www.google.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "https://www.google.com/favicon.ico";
        definedAliases = [ "@g" "@google" ];
      };

      "claude" = {
        name = "Claude";
        urls = [{
          template = "https://claude.ai/new";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "https://claude.ai/favicon.ico";
        definedAliases = [ "@cl" "@claude" ];
      };

      "google-ai" = {
        name = "Google AI";
        urls = [{
          template = "https://www.google.com/search";
          params = [
            { name = "udm"; value = "50"; }
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "https://www.google.com/favicon.ico";
        definedAliases = [ "@gemini" ];
      };

      "nix-packages" = {
        name = "Nix Packages";
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "nix-options" = {
        name = "Nix Options";
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "home-manager" = {
        name = "Home Manager";
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "source"; value = "home_manager"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@hm" ];
      };

      "youtube" = {
        name = "YouTube";
        urls = [{
          template = "https://www.youtube.com/results";
          params = [
            { name = "search_query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "https://www.youtube.com/favicon.ico";
        definedAliases = [ "@yt" "@youtube" ];
      };

      "x" = {
        name = "X";
        urls = [{
          template = "https://x.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];

        icon = "https://x.com/favicon.ico";
        definedAliases = [ "@x" ];
      };

      bing.metaData.hidden = true;
      ddg.metaData.hidden = true;
      mojeek.metaData.hidden = true;
    };
  };

  commonSettings = {
    "network.trr.mode" = 3;
    "network.trr.uri" = "https://dns.quad9.net/dns-query";

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "devtools.chrome.enabled" = true;

    "browser.startup.homepage" = "about:home";
    "browser.startup.page" = 1;
    "browser.urlbar.share-button.enabled" = true;
    "browser.urlbar.trimURLs" = false;
    "browser.toolbars.bookmarks.visibility" = "never";
    "browser.uiCustomization.state" = builtins.toJSON (builtins.fromJSON (builtins.readFile ./layout.json));
  };

  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

in
  {
  imports = [
    ./librewolf-bookmarks.nix
  ];

  stylix.targets.librewolf.colorTheme.enable = true;
  stylix.targets.librewolf.profileNames = [ "mathieu-default" ];

  programs.librewolf = {
    enable = true;

    globalExtensions = [
      { package = addons.ublock-origin; settings = { private_browsing = true; default_area = "menupanel"; }; }
      { package = addons.proton-pass; settings = { private_browsing = true; default_area = "navbar"; }; }
      { package = addons.proton-vpn; settings = { private_browsing = true; default_area = "navbar"; }; }
      { package = addons.sidebery; settings = { private_browsing = true; default_area = "menupanel"; }; }

      { package = addons.don-t-fuck-with-paste; settings = { private_browsing = false; default_area = "menupanel"; }; }
      { package = addons.consent-o-matic; settings = { private_browsing = false; default_area = "menupanel"; }; }
      { package = addons.vimium; settings = { private_browsing = false; default_area = "menupanel"; }; }
      { package = addons.violentmonkey; settings = { private_browsing = false; default_area = "menupanel"; }; }
    ];

    policies = {
      Cookies = {
        Allow = [
          "https://web.whatsapp.com"
          "https://proton.me"

          "https://accounts.google.com"
          "https://login.microsoftonline.com"

          "https://amazon.fr"
          "https://amazon.com"

          "https://figma.com"
          "https://github.com"
          "https://claude.ai"
          "https://startpage.com"

          "https://sentience-robotics.fr"
          "https://lucy-robotics.com"

          "https://monkeytype.com"

          "https://x.com"
          "https://linkedin.com"
        ];
      };
    };

    profiles = {
      mathieu-default = {
        id = 0;
        isDefault = true;
        extensions.force = true;
        search = commonSearch;
        settings = commonSettings // {
          "privacy.resistFingerprinting" = true;
          "privacy.fingerprintingProtection" = true;
          "webgl.disabled" = true;
          "webgl.enable-webgl2" = false;
        };

        userChrome = builtins.readFile ./userChrome.css;
      };

      mathieu-webgl = {
        id = 1;
        isDefault = false;
        extensions.force = true;
        search = commonSearch;
        settings = commonSettings // {
          "privacy.resistFingerprinting" = false;
          "privacy.fingerprintingProtection" = false;
          "webgl.disabled" = false;
          "webgl.enable-webgl2" = true;
          "layers.acceleration.force-enabled" = true;
        };

        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };

  home.packages = [
    (lib.hiPrio librewolf-jailed)
  ];
}
