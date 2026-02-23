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
      barScale = lib.mkOption {
        description = "Bar GUI Scale";
        type = lib.types.float;
        default = 1.0;
      };
      batteryWidget = lib.mkOption {
        description = "To turn on Battery Widget";
        type = lib.types.bool;
        default = false;
      };
      autostart = lib.mkOption {
        description = "Shellscript To Run Eachtime Qtile is Restarted";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nitrogen --restore &
          # /home/L0L1P0P/.config/polybar/launch.sh &
          setxkbmap -layout us,ir -option 'grp:alt_shift_toggle' &
        '';
      };
      autostartOnce = lib.mkOption {
        description = "Shellscript to Run Once On Login";
        type = lib.types.lines;
        default = ''
          #!/usr/bin/env bash

          nm-applet &
          clash-verge-rev &
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
        from qtile_extras import widget
        from qtile_bonsai import Bonsai

        import os
        import subprocess

        home = os.path.expanduser("~")
        mod = "mod4"
        terminal = guess_terminal()

        margin = ${builtins.toString config.qtile.margin}
        border_width = ${builtins.toString config.qtile.borderWidth}
        gui_scale = ${builtins.toString config.qtile.barScale}

        keys = [
            Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
            Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
            Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
            Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
            Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
            Key([mod], "period", lazy.next_screen(), desc="Focuses the next screen"),
            Key([mod], "comma", lazy.prev_screen(), desc="Focuses the previous screen"),
            Key(
                [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
            ),
            Key(
                [mod, "shift"],
                "l",
                lazy.layout.shuffle_right(),
                desc="Move window to the right",
            ),
            Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
            Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
            Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
            Key(
                [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
            ),
            Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
            Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
            Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
            Key(
                [mod, "shift"],
                "Return",
                lazy.layout.toggle_split(),
                desc="Toggle between split and unsplit sides of stack",
            ),
            Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
            Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
            Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
            Key(
                [mod],
                "f",
                lazy.window.toggle_fullscreen(),
                desc="Toggle fullscreen on the focused window",
            ),
            Key(
                [mod],
                "t",
                lazy.window.toggle_floating(),
                desc="Toggle floating on the focused window",
            ),
            Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
            Key(
                [mod, "control"],
                "q",
                lazy.spawn(
                    "rofi -show power-menu -modi power-menu:~/.config/rofi/rofi-power-menu.sh"
                ),
                desc="Open Powermenu",
            ),
            Key(
                [mod],
                "r",
                lazy.spawn("rofi -monitor -1 -show drun -show-icons"),
                desc="Spawn a command using rofi",
            ),
            Key(
                [mod, "shift"],
                "s",
                lazy.spawn(home + "/.config/qtile/screenshot.sh", shell=True),
            ),
        ]


        color = {
            "background": "#282828",
            "background_light": "#383838",
            "foreground": "#ebdbb2",
            "alert": "#cc241d",
            "green": "#98971a",
            "yellow": "#d79921",
            "blue": "#458588",
            "purple": "#b16286",
            "aqua": "#689d6a",
            "mint": "#83a598",
            "red": "#fb4934",
            "orange": "#fe8019",
            "disabled": "#707880",
        }


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
            border_normal="#8ec07c",
            border_focus="#8ec07c",
            border_width=0,
            float_rules=[
                # Run the utility of `xprop` to see the wm class and name of an X client.
                *layout.Floating.default_float_rules,
                Match(wm_class="confirmreset"),  # gitk
                Match(wm_class="makebranch"),  # gitk
                Match(wm_class="maketag"),  # gitk
                Match(wm_class="ssh-askpass"),  # ssh-askpass
                Match(title="branchdialog"),  # gitk
                Match(title="pinentry"),  # GPG key password entry
            ],
        )

        layouts = [
            layout.Columns(
                border_focus=color["aqua"],
                border_normal=color["mint"],
                border_focus_stack=color["orange"],
                border_normal_stack=color["yellow"],
                border_width=border_width,
                margin=margin,
            ),
            Bonsai(),
            layout.Max(
                border_focus=color["aqua"],
                border_normal=color["mint"],
                border_width=border_width,
                margin=margin,
            ),
        ]

        # Drag floating layouts.
        mouse = [
            Drag(
                [mod],
                "Button1",
                lazy.window.set_position_floating(),
                start=lazy.window.get_position(),
            ),
            Drag(
                [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
            ),
            Click([mod], "Button2", lazy.window.bring_to_front()),
        ]

        widget_defaults = dict(
            font="JetBrainsMono Nerd Font Bold",
            fontsize=int(12 * gui_scale),
            padding=int(3 * gui_scale),
            foreground=color["foreground"],
        )
        extension_defaults = widget_defaults.copy()
        seperator_widget = widget.Sep(
            padding=int(24 * gui_scale),
            size_percent=60,
            linewidth=1,
            foreground=color["foreground"],
        )

        screens = [
            Screen(
                top=bar.Bar(
                    [
                        widget.GroupBox(
                            highlight_method="line",
                            highlight_color=[color["background"], color["background_light"]],
                            active=color["foreground"],
                            inactive=color["disabled"],
                            this_current_screen_border=color["orange"],
                            other_current_screen_border=color["blue"],
                            this_screen_border=color["disabled"],
                            other_screen_border=color["disabled"],
                        ),
                        seperator_widget,
                        widget.CurrentLayoutIcon(
                            scale=0.65,
                            use_mask=True,
                            foreground=color["orange"],
                            fontsize=int(16 * gui_scale),
                        ),
                        widget.CurrentLayout(
                            scale=0.6,
                            icon_first=False,
                            foreground=color["orange"],
                            fontsize=int(14 * gui_scale),
                        ),
                        seperator_widget,
                        widget.ContinuousPoll(
                            cmd="xkbmon -u", fmt="󰌌  {}", foreground=color["green"]
                        ),
                        seperator_widget,
                        widget.Systray(
                            icon_size=int(15 * gui_scale), padding=int(8 * gui_scale)
                        ),
                        seperator_widget,
                        widget.Prompt(),
                        widget.WindowName(for_current_screen=True),
                        widget.Mpris2(
                            format="{xesam:artist} - {xesam:title}",
                            no_metadata_text="",
                            paused_text="  {track}",
                            playing_text="󰝚  {track}",
                            poll_interval=1,
                            stopped_text="󰽺",
                            foreground=color["aqua"],
                        ),
                        seperator_widget,
                        widget.CPU(
                            format="  CPU{freq_current: .2f}GHz {load_percent}%",
                            foreground=color["orange"],
                        ),
                        seperator_widget,
                        widget.Memory(
                            format="  RAM{MemPercent: .1f}%", foreground=color["blue"]
                        ),
                        seperator_widget,
                        widget.Net(
                            format="󰛳 NET 󰄠{down: .2f}{down_suffix} 󰄝{up: .2f}{up_suffix}",
                            foreground=color["purple"],
                        ),
                        seperator_widget,
                        widget.PulseVolume(
                            unmute_format="  {volume}%",
                            foreground=color["green"],
                            mute_format="婢 muted",
                            mute_foreground=color["red"],
                        ),
                        seperator_widget,
                        widget.Clock(
                            format="󰃰  %Y-%m-%d %a %H:%M:%S",
                            foreground=color["foreground"],
                            fontsize=int(12 * gui_scale),
                        ),
                        seperator_widget,
                        ${lib.optionalString config.qtile.batteryWidget ''
                          widget.Battery(
                              charge_char="󰂄",
                              charging_foreground=color["aqua"],
                              full_char="󰁹",
                              full_foreground=color["blue"],
                              discharge_char="󰂍",
                              foreground=color["yellow"],
                              empty_char="󱉞",
                              low_percentage=0.2,
                              low_foreground=color["red"],
                              update_interval=30,
                              format="{char} {percent:2.0%} ~{hour:d}:{min:02d}  ",
                          ),
                        ''}
                        widget.TextBox(
                            "⏻  ",
                            foreground=color["red"],
                            mouse_callbacks={
                                "Button1": lazy.spawn(
                                    "rofi -show power-menu -modi power-menu:~/.config/rofi/rofi-power-menu.sh"
                                ),
                            },
                        ),
                    ],
                    int(24 * gui_scale),
                    border_width=[0, 0, int(2 * gui_scale), 0],  # Draw top and bottom borders
                    border_color=[
                        color["background"],
                        color["background"],
                        color["background"],
                        color["background"],
                    ],
                    background=color["background"],
                ),
                x11_drag_polling_rate=170,
            ),
        ]

        dgroups_key_binder = None
        dgroups_app_rules = []
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
        os.environ["XDG_CURRENT_DESKTOP"] = "qtile"


        @hook.subscribe.startup_once
        def autostart_once():
            home = os.path.expanduser("~")
            subprocess.run([home + "/.config/qtile/autostart_once.sh"])


        @hook.subscribe.startup
        def autostart():
            home = os.path.expanduser("~")
            subprocess.run([home + "/.config/qtile/autostart.sh"])


        wmname = "LG3D"
      '';
    };
  };
}
