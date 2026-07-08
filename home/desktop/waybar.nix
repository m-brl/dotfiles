{ config, pkgs, ... }:

let
  playerScript = pkgs.writeShellScriptBin "player.sh" ''
    title=$((playerctl metadata --format '{{title}}' || echo "No media found") | sed -e 's/&/&amp;/g')
    [[ ''${#title} -gt 20 ]] && title="''${title:0:17}..."
    artist=$((playerctl metadata --format '{{artist}}' || echo "No artist") | sed -e 's/&/&amp;/g')
    [[ ''${#artist} -gt 20 ]] && artist="''${artist:0:17}..."
    printf " 󰝚 %s - %s " "$title" "$artist"
  '';

  playScript = pkgs.writeShellScriptBin "play.sh" ''
    status=$(playerctl status)
    if [[ "$status" == "Paused" ]]; then
      echo ' 󰐎 '
    else
      echo ' 󰏤 '
    fi
  '';

in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "graphical-session.target" ];
    };

    settings = [{
      layer = "top";
      position = "top";
      height = 32;

      modules-left = ["hyprland/workspaces"];
      modules-center = ["custom/media" "custom/prev" "custom/play" "custom/next"];
      modules-right = ["network" "bluetooth" "pulseaudio" "battery" "clock#local" "clock#chicoutimi" "custom/weather" "custom/notification"];

      "custom/media" = {
        exec = "bash -c \"${playerScript}/bin/player.sh\"";
        interval = 1;
      };

      "custom/prev" = {
        exec = "bash -c \"echo ' 󰒮 '\"";
        on-click = "bash -c \"playerctl previous\"";
        interval = 1;
      };

      "custom/play" = {
        exec = "bash -c \"${playScript}/bin/play.sh\"";
        on-click = "bash -c \"playerctl play-pause\"";
        interval = 1;
      };

      "custom/next" = {
        exec = "bash -c \"echo ' 󰒭 '\"";
        on-click = "bash -c \"playerctl next\"";
        interval = 1;
      };

      "network" = {
        on-click = "nm-connection-editor";
        format-wifi = " <span color='#cba6f7'>󰖩</span> ";
        format-ethernet = " <span color='#cba6f7'>󰈀</span> ";
        tooltip-format = " <span color='#FF1493'>󰕒</span> {bandwidthUpOctets}  <span color='#00BFFF'>󰇚</span> {bandwidthDownOctets}";
        format-linked = " <span color='#cba6f7'>󱘖</span> ";
        format-disconnected = " <span color='#cba6f7'>󰌙</span> ";
        interval = 1;
      };

      "bluetooth" = {
        format = " <span color='#cba6f7'>󰂲</span> ";
        on-click = "blueman-manager";
        format-connected = " <span color='#cba6f7'>󰂱</span> ";
        format-connected-battery = " <span color='#cba6f7'>󰂱</span> ";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
      };

      "pulseaudio" = {
        format = " <span color='#cba6f7'>{icon}</span> ";
        format-muted = " <span color='#cba6f7'>󰝟</span> ";
        format-icons = {
          headphone = "󱡏";
          hands-free = "󰋎";
          headset = "󰋎";
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pavucontrol -t 3";
        on-click-right = "pactl -- set-sink-mute 0 toggle";
        tooltip = true;
        tooltip-format = "Volume: {volume}%";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = " <span color='#cba6f7'>{icon}</span> {capacity}% ";
        format-charging = " 󱐋 {capacity}% ";
        interval = 1;
        format-icons = ["󰁺" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        tooltip = true;
      };

      "clock#local" =  {
        interval = 1;
        timezone = "Europe/Paris";
        format = " <span color='#cba6f7'>󰥔</span> {:%H:%M} ";
        tooltip = true;
        tooltip-format = "{:%H:%M}";
      };

      "clock#chicoutimi" = {
        interval = 1;
        timezone = "America/Toronto";
        format = " <span color='#cba6f7'>󰥔</span> {:%H:%M} ";
        tooltip = true;
        tooltip-format = "{:%H:%M}";
      };

      "custom/weather" = {
        exec = "bash -c \"$HOME/.config/waybar/scripts/weather.sh\"";
        return-type = "json";
        interval = 300;
        format = "{}";
        tooltip = true;
      };
      
      "custom/notification" = {
        exec = "bash -c \"$HOME/.config/waybar/scripts/notification.sh\"";
        on-click = "bash -c \"swaync-client -t -sw\"";
        interval = 1;
      };
    }];

    style = builtins.readFile ./waybar-style.conf;
  };
}
