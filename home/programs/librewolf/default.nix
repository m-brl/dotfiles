{ inputs, config, pkgs, ... }:

let
  commonSearch = {
    default = "Startpage";
    privateDefault = "Startpage";
    force = true;

    engines = {
      "Startpage" = {
        name = "Startpage";
        urls = [{
          template = "https://www.startpage.com/sp/search";
          params = [
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        icon = "https://www.startpage.com/favicon.ico";
        definedAliases = [ "@sp" ];
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

in
  {
  imports = [
    ./librewolf-bookmarks.nix
  ];

  stylix.targets.librewolf.colorTheme.enable = true;
  stylix.targets.librewolf.profileNames = [ "mathieu-default" ];

  programs.librewolf = {
    enable = true;

    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
          default_area = "menupanel";
        };

        "DontFuckWithPaste@raim.ist" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/don-t-fuck-with-paste/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };

        "gdpr@cavi.au.dk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };

        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };

        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };

        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "force_installed";
          default_area = "menupanel";
        };

        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
        };

        "vpn@proton.ch" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          installation_mode = "force_installed";
          default_area = "navbar";
          private_browsing = true;
        };
      };

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
        isDefault = true;
        id = 0;

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
}
