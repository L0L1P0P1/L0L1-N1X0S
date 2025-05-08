{
  lib,
  config,
  options,
  pkgsUnstable,
  ...
}:
{

  options = {
    qtile = {
      enable = lib.mkEnableOption "enables qtile";
      borderWidth = lib.mkOption {
        description = "Window Border Widths";
        type = lib.types.int;
        default = 5;
      };
      margin = lib.mkOption {
        description = "Window Margins";
        type = lib.types.int;
        default = 10;
      };
      autostart = lib.mkOption {
        description = "Shellscript To Run Eachtime Qtile is Restarted";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nitrogen --restore &
          /home/L0L1P0P/.config/polybar/launch.sh &
          setxkbmap -layout us,ir -option 'grp:alt_shift_toggle' &
        '';
      };
      autostartOnce = lib.mkOption {
        description = "Shellscript to Run Once On Login";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nekoray -tray &
          lxqt-policykit-agent &
        '';
      };
    };
  };

  config = lib.mkIf config.qtile.enable {
    xdg.configFile = {
      "qtile/autostart.sh" = {
        text = ''${config.qtile.autostart}'';
        executable = true;
      };
      "qtile/autostart_once.sh" = {
        text = ''${config.qtile.autostartOnce}'';
        executable = true;
      };
      "qtile/screenshot.sh" = {
        text = ''
          #!/usr/bin/env bash
          maim -o -s | tee ~/Pictures/screenshots/$(date +%s).png | xclip -selection clipboard -t image/png
        '';
        executable = true;
      };

      "qtile/config.py".text = ''
        from libqtile import bar, layout, qtile, widget, hook
        from libqtile.config import Click, Drag, Group, Key, Match, Screen
        from libqtile.lazy import lazy
        from libqtile.utils import guess_terminal

        import os
        import subprocess

        home = os.path.expanduser('~')
        mod = "mod4"
        terminal = guess_terminal()

        keys = [
        	Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        	Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        	Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        	Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        	Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
        	Key([mod], "period", lazy.next_screen(), desc="Focuses the next screen"),
        	Key([mod], "comma", lazy.prev_screen(), desc="Focuses the previous screen"),
        	Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        	Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        	Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        	Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        	Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        	Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        	Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        	Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        	Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        	Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
        	Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
        	Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        	Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
        	Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
        	Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
        	Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        	Key([mod, "control"], "q", lazy.spawn("rofi -show power-menu -modi power-menu:rofi-power-menu"), desc="Shutdown Qtile"),
        	Key([mod], "r", lazy.spawn("rofi -monitor -1 -show drun -show-icons"), desc="Spawn a command using a prompt widget"),
        	Key([mod, "shift"], "s", lazy.spawn(home + "/.config/qtile/screenshot.sh", shell=True)),
        ]

        for vt in range(1, 8):
        	keys.append(
        		Key(
        			["control", "mod1"],
        			f"f{vt}",
        			lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
        			desc=f"Switch to VT{vt}",
        		)
        	)

        groups = [Group(i) for i in "123456789"]

        for i in groups:
        	keys.extend(
        		[
        			Key(
        				[mod],
        				i.name,
        				lazy.group[i.name].toscreen(),
        				desc=f"Switch to group {i.name}",
        			),
        			Key(
        				[mod, "shift"],
        				i.name,
        				lazy.window.togroup(i.name, switch_group=False),
        				desc=f"Move focused window to group {i.name}",
        			),
        		]
        	)

        floating_layout = layout.Floating(
        	border_normal="#8ec07c",border_focus="#8ec07c", border_width = ${builtins.toString config.qtile.borderWidth},
        	float_rules=[
        		# Run the utility of `xprop` to see the wm class and name of an X client.
        		*layout.Floating.default_float_rules,
        		Match(wm_class="confirmreset"),  # gitk
        		Match(wm_class="makebranch"),  # gitk
        		Match(wm_class="maketag"),  # gitk
        		Match(wm_class="ssh-askpass"),  # ssh-askpass
        		Match(title="branchdialog"),  # gitk
        		Match(title="pinentry"),  # GPG key password entry
        	]
        )

        layouts = [
        	layout.Columns(border_focus='#689d6a', border_normal='#83a598', border_focus_stack='#fe8019', border_normal_stack='#d79921', border_width=${builtins.toString config.qtile.borderWidth}, margin=${builtins.toString config.qtile.margin}),
        	layout.Max(border_focus='#689d6a', border_normal='#83a598', border_width=${builtins.toString config.qtile.borderWidth}, margin=${builtins.toString config.qtile.margin}),
        ]

        widget_defaults = dict(
        	font="sans",
        	fontsize=12,
        	padding=3,
        )
        extension_defaults = widget_defaults.copy()

        # Drag floating layouts.
        mouse = [
        	Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
        	Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
        	Click([mod], "Button2", lazy.window.bring_to_front()),
        ]

        screens = [Screen()]

        dgroups_key_binder = None
        dgroups_app_rules = []  # type: list
        follow_mouse_focus = True
        bring_front_click = True
        floats_kept_above = True
        cursor_warp = False 
        auto_fullscreen = True
        focus_on_window_activation = "smart"
        reconfigure_screens = True
        auto_minimize = True
        wl_input_rules = None
        wl_xcursor_theme = None
        wl_xcursor_size = 32 
        os.environ["XDG_CURRENT_DESKTOP"] = "qtile"

        @hook.subscribe.startup_once
        def autostart_once():
        	home = os.path.expanduser('~')
        	subprocess.run([home + '/.config/qtile/autostart_once.sh'])

        @hook.subscribe.startup
        def autostart():
        	home = os.path.expanduser('~')
        	subprocess.run([home + '/.config/qtile/autostart.sh'])

        wmname = "LG3D"
      '';
    };
  };
}
