{ inputs, config, pkgs, ... }:

{
  imports = [
    ./librewolf-bookmarks.nix
  ];

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
        };

        "vpn@proton.ch" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };

      Cookies = {
        Allow = [
          "https://web.whatsapp.com/"
          "https://proton.me/"
          "https://google.com/"
          "https://youtube.com/"
          "https://login.microsoftonline.com"
          "https://cloud.microsoft"
          "https://github.com"
          "https://claude.ai"
          "https://x.com"
          "https://startpage.com"

          "https://sentience-robotics.fr"
          "https://lucy-robotics.com"
        ];
      };
    };

    profiles = {
      mathieu = {
        isDefault = true;

        search = {
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

        settings = {
          "privacy.resistFingerprinting" = false;
          "privacy.fingerprintingProtection" = true;

          "network.trr.mode" = 3;
          "network.trr.uri" = "https://dns.quad9.net/dns-query";

          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "devtools.chrome.enabled" = true;

          "browser.urlbar.share-button.enabled" = true;
          "browser.urlbar.trimURLs" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.uiCustomization.state" = builtins.toJSON {
            placements = {
              "nav-bar" = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "customizableui-special-spring1"
                "vpn_proton_ch-browser-action"
                "urlbar-container"
                "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
                "customizableui-special-spring2"
                "downloads-button"
                "unified-extensions-button"
              ];
            };
            seen = [
              "downloads-button"
              "unified-extensions-button"
              "vpn_proton_ch-browser-action"
              "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
            ];
            dirtyAreaCache = [
              "nav-bar"
            ];
            currentVersion = 35;
            newElementCount = 0;
          };
        };

        userChrome = builtins.readFile ./userChrome.css;
      };
    };
  };
}
