{ inputs, config, osConfig, pkgs, slib, ... }:

{
  programs.newsboat = {
    enable = true;
    autoReload = true;

    urls = [
      { url = "https://www.franceinfo.fr/titres.rss"; tags = [ "actu" "france" "!" ]; }
      { url = "https://www.lemonde.fr/rss/une.xml"; tags = [ "actu" "france" "!" ]; }
      { url = "https://www.lemonde.fr/international/rss_full.xml"; tags = [ "actu" "monde" "!" ]; }

      { url = "https://meteo.gc.ca/rss/weather/48.444_-71.057_f.xml"; tags = [ "meteo" "quebec" "!" ]; title = "Météo Chicoutimi-Nord"; }

      { url = "https://ici.radio-canada.ca/info/rss/saguenay-lac-saint-jean/en-continu"; tags = [ "actu" "quebec" "!" ]; }
      { url = "https://www.rds.ca/arc/outboundfeeds/rss/category/hockey/canadiens/?outputType=xml"; tags = [ "hockey" "nhl" "quebec" "!" ]; title = "RDS Canadiens"; }
      { url = "https://news.google.com/rss/search?q=LHJMQ&hl=fr-CA&gl=CA&ceid=CA:fr"; tags = [ "hockey" "lhjmq" "!" ]; title = "LHJMQ (Google News)"; }

      { url = "https://news.ycombinator.com/rss"; tags = [ "tech" "!" ]; }
      { url = "https://www.numerama.com/feed/"; tags = [ "tech" "fr" "!" ]; }
      { url = "https://linuxfr.org/news.atom"; tags = [ "tech" "fr" "open" "!" ]; }

      { url = "https://www.quantamagazine.org/feed/"; tags = [ "science" "!" ]; }
    ];

    queries = {
      "📰 France" = ''tags # "france"'';
      "🌎 Monde" = ''tags # "monde"'';
      "⚜️ Québec" = ''tags # "quebec"'';
      "🏒 Hockey"  = ''tags # "hockey"'';
      "💻 Tech"    = ''tags # "tech"'';
      "⛅ Météo"   = ''tags # "meteo"'';
    };

    extraConfig = ''
      notify-program "${pkgs.libnotify}/bin/notify-send"
      notify-format "Newsboat : %d new articles (%n unread articles, %f unread feeds)"
    '';
  };

  systemd.user.services.newsboat-reload = {
    Unit.Description = "Reload newsboat feeds";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.newsboat}/bin/newsboat -x reload";
    };
  };

  systemd.user.timers.newsboat-reload = {
    Unit.Description = "Reload newsboat feeds every 15 minutes";
    Timer = {
      OnCalendar = "*:0/15";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
