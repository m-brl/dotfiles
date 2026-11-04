{ lib, pkgs, ... }:

let
  inherit (lib.generators) mkLuaInline;

  mod = "SUPER";

  mkBind = {key, action, flags ? { } }: {
    _args = [ key (mkLuaInline action) ]
    ++ lib.optional (flags != { }) flags;
  };

  mkExec = {key, command, flags ? { } }: mkBind {
    inherit key flags;
    action = "hl.dsp.exec_cmd(${builtins.toJSON command})";
  };

  workspaces = lib.range 1 10;
  wsKey = i: toString (lib.mod i 10);

  moveOrGroup = direction: forward: ''
    function()
      local w = hl.get_active_window()
      if not w then return end
      if w.group ~= nil then
        hl.dispatch(hl.dsp.group.move_window({ forward = ${forward} }))
      else
        hl.dispatch(hl.dsp.window.move({ direction = "${direction}", group_aware = true }))
      end
    end
  '';
in
{
  wayland.windowManager.hyprland.settings.bind = [
    (mkBind { key = "${mod} + SHIFT + Q"; action = "hl.dsp.window.close()"; })

    (mkExec { key = "${mod} + Return"; command = "${lib.getExe pkgs.kitty}"; })
    (mkExec { key = "${mod} + Backspace"; command = "loginctl lock-session"; })
    (mkBind { key = "${mod} + Semicolon"; action = "hl.dsp.group.lock({ action = 'toggle' })"; })
    (mkExec { key = "${mod} + D"; command = "${lib.getExe pkgs.rofi} -show drun"; })
    (mkExec { key = "${mod} + V"; command = ''bash -c "cliphist list | wofi --show dmenu | cliphist decode | wl-copy"''; })

    (mkBind { key = "${mod} + H"; action = "hl.dsp.focus({ direction = 'left' })"; })
    (mkBind { key = "${mod} + L"; action = "hl.dsp.focus({ direction = 'right' })"; })
    (mkBind { key = "${mod} + K"; action = "hl.dsp.focus({ direction = 'up' })"; })
    (mkBind { key = "${mod} + J"; action = "hl.dsp.focus({ direction = 'down' })"; })

    (mkBind { key = "${mod} + SHIFT + SPACE"; action = ''hl.dsp.window.float({ action = "toggle"; })''; })

    (mkBind { key = "${mod} + W"; action = "hl.dsp.group.toggle()"; })
    (mkBind { key = "${mod} + SHIFT + H"; action = moveOrGroup "left" "false"; })
    (mkBind { key = "${mod} + SHIFT + L"; action = moveOrGroup "right" "true"; })
    (mkBind { key = "${mod} + SHIFT + K"; action = "hl.dsp.window.move({ direction = 'up', group_aware = true })"; })
    (mkBind { key = "${mod} + SHIFT + J"; action = "hl.dsp.window.move({ direction = 'down', group_aware = true })"; })

    (mkExec { key = "Print"; command = ''bash -c "grim -t png -g \"$(slurp)\" - | wl-copy"''; })
    (mkExec { key = "${mod} + Print"; command = ''bash -t "png -c grim - | wl-copy"''; })

    (mkExec { key = "XF86AudioPrev"; command = "${lib.getExe pkgs.playerctl} previous"; })
    (mkExec { key = "XF86AudioNext"; command = "${lib.getExe pkgs.playerctl} next"; })
    (mkExec { key = "XF86AudioPlay"; command = "${lib.getExe pkgs.playerctl} play-pause"; })

    (mkExec { key = "XF86AudioMute"; command = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; })
    (mkExec { key = "XF86AudioMicMute"; command = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; })
    (mkExec { key = "XF86AudioRaiseVolume"; command = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0"; flags.repeating = true; })
    (mkExec { key = "XF86AudioLowerVolume"; command = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 0.0"; flags.repeating = true; })
    (mkExec { key = "XF86Display"; command = "${lib.getExe pkgs.nwg-displays}"; })

    (mkExec { key = "XF86MonBrightnessUp"; command = "${lib.getExe pkgs.brightnessctl} set +5%"; flags.repeating = true; })
    (mkExec { key = "XF86MonBrightnessDown"; command = "${lib.getExe pkgs.brightnessctl} set 5%-"; flags.repeating = true; })

    (mkExec { key = "XF86NotificationCenter"; command = "${pkgs.swaynotificationcenter}/bin/swaync-client --open-panel"; })
    (mkExec { key = "XF86PickupPhone"; command = "${lib.getExe pkgs.brightnessctl} set +5%"; flags.repeating = true; })
    (mkExec { key = "XF86HangupPhone"; command = "${lib.getExe pkgs.brightnessctl} set +5%"; flags.repeating = true; })

    (mkBind { key = "XF86Favorites"; action = ''hl.dsp.workspace.toggle_special("magic")''; })
    (mkBind { key = "SHIFT + XF86Favorites"; action = ''hl.dsp.window.move({ workspace = "special:magic" })''; })
  ]
  ++ map (i: mkBind { key = "${mod} + ${wsKey i}"; action = "hl.dsp.focus({ workspace = ${toString i} })"; }) workspaces
  ++ map (i: mkBind { key = "${mod} + SHIFT + ${wsKey i}"; action = "hl.dsp.window.move({ workspace = ${toString i}, follow = false })"; }) workspaces;
}
