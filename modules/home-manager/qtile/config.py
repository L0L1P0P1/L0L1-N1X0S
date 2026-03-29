from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, EzKey, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget as widget_extras
from qtile_bonsai import Bonsai

import os
import subprocess
import tomllib

home = os.path.expanduser("~")
mod = "mod4"
terminal = guess_terminal()

with open(home + "/.config/qtile/options.toml", "rb") as t:
    options = tomllib.load(t)

margin = options["margin"]
border_width = options["border_width"]
gui_scale = options["bar_scale"]
battery_widget_switch = options["battery_widget"]


powermenu_cmd = (
    "rofi -show power-menu -modi power-menu:~/.config/rofi/rofi-power-menu.sh"
)
rofi_cmd = "rofi -monitor -1 -show drun -show-icons"
screenshot_cmd = home + "/.config/qtile/screenshot.sh"

#### START KEYBINDINGS ####
# fmt: off
keys = [
    # Reload Config
    EzKey("M-C-r", lazy.reload_config(), desc="Reload the config"),

    # Move Focus
    EzKey("M-h", lazy.layout.left(), desc="Move focus to left"),
    EzKey("M-l", lazy.layout.right(), desc="Move focus to right"),
    EzKey("M-j", lazy.layout.down(), desc="Move focus down"),
    EzKey("M-k", lazy.layout.up(), desc="Move focus up"),
    EzKey("M-z", lazy.layout.next(), desc="Move window focus to other window"),

    # Change Screen
    Key([mod], "period", lazy.next_screen(), desc="Focuses the next screen"),
    Key([mod], "comma", lazy.prev_screen(), desc="Focuses the previous screen"),

    # Change Layout
    EzKey("M-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], 49, lazy.prev_layout(), desc="Previuous Layout"),

    # Toggle Fullscreen
    EzKey("M-g", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),

    # Toggle Floating
    EzKey("M-y", lazy.window.toggle_floating(), desc="Toggle floating on the focused window",),

    # Move Windows
    EzKey("M-S-h", lazy.layout.shuffle_left(), lazy.layout.swap("left").when(layout="bonsai"), desc="Move window to the left"),
    EzKey("M-S-l", lazy.layout.shuffle_right(), lazy.layout.swap("right").when(layout="bonsai"), desc="Move window to the right"),
    EzKey("M-S-j", lazy.layout.shuffle_down(), lazy.layout.swap("down").when(layout="bonsai"), desc="Move window down"),
    EzKey("M-S-k", lazy.layout.shuffle_up(), lazy.layout.swap("up").when(layout="bonsai"), desc="Move window up"),

    # Grow Windows
    EzKey("M-C-h", lazy.layout.grow_left(), lazy.layout.resize("left", 100).when(layout="bonsai"), desc="Grow window to the left"),
    EzKey("M-C-l", lazy.layout.grow_right(), lazy.layout.resize("right", 100).when(layout="bonsai"), desc="Grow window to the right"),
    EzKey("M-C-j", lazy.layout.grow_down(), lazy.layout.resize("down", 100).when(layout="bonsai"), desc="Grow window down"),
    EzKey("M-C-k", lazy.layout.grow_up(), lazy.layout.resize("up", 100).when(layout="bonsai"), desc="Grow window up"),
    EzKey("M-n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Split (Columns)
    EzKey("M-S-<Return>", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    # Monad Layout Keys
    EzKey("M-i", lazy.layout.grow(), desc="Monad Grow"),
    EzKey("M-m", lazy.layout.shrink(), desc="Monad Shrink"),
    EzKey("M-n", lazy.layout.reset(), desc="Monad Reset"),
    EzKey("M-S-<space>", lazy.layout.flip(), desc="Monad Flip"),

    # Terminal
    EzKey("M-<Return>", lazy.spawn(terminal), desc="Launch terminal"),

    # Spawn with Rofi
    EzKey("M-r", lazy.spawn(rofi_cmd), desc="Spawn a command using rofi",),

    # Kill Window
    EzKey("M-w", lazy.window.kill(), desc="Kill focused window"),


    # Open Powermenu
    EzKey("M-C-q", lazy.spawn(powermenu_cmd), desc="Open Powermenu",),

    # Screenshot
    EzKey("M-S-s", lazy.spawn(screenshot_cmd, shell=True), desc="Screenshot"),

    # Function Keys
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%"), desc="Turn Up Brightness",),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-"), desc="Turn Down Brightness",),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ .02+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ .02-"),),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
]


## Bonsai Layout Keys
keys.extend([
      # Spawning
      EzKey("M-v", lazy.layout.spawn_split(rofi_cmd, "x").when(layout="bonsai"), desc="Bonsai Vertical Split"),
      EzKey("M-x", lazy.layout.spawn_split(rofi_cmd, "y").when(layout="bonsai"), desc="Bonsai Horizontal Split",),
      EzKey("M-t", lazy.layout.spawn_tab(rofi_cmd).when(layout="bonsai")),
      EzKey("M-S-t", lazy.layout.spawn_tab(rofi_cmd, new_level=True).when(layout="bonsai")),
      EzKey("M-S-v", lazy.layout.spawn_split(rofi_cmd, "x", position="previous"), desc="Bonsai Vertical Split Previous Position",),
      EzKey("M-S-x", lazy.layout.spawn_split(rofi_cmd, "y", position="previous", desc="Bonsai Horizontal Split Previous Position",),),

      # Movement and Manimulation
      EzKey("M-f", lazy.layout.next_tab().when(layout="bonsai"), desc="Bonsai Next Tab"),
      EzKey("M-d", lazy.layout.prev_tab().when(layout="bonsai"), desc="Bonsai Previous Tab"),
      EzKey("M-S-d", lazy.layout.swap_tabs("previous").when(layout="bonsai")),
      EzKey("M-S-f", lazy.layout.swap_tabs("next").when(layout="bonsai")),
      Key([mod], "o", lazy.layout.select_container_outer().when(layout="bonsai")),
      Key([mod], "p", lazy.layout.select_container_inner().when(layout="bonsai")),

      # Chords
      KeyChord(
          [mod],
          "b",
          [
              # Spawning Terminals Fast
              EzKey("v", lazy.layout.spawn_split(terminal, "x")),
              EzKey("x", lazy.layout.spawn_split(terminal, "y")),
              EzKey("t", lazy.layout.spawn_tab(terminal)),
              EzKey("S-t", lazy.layout.spawn_tab(terminal, new_level=True)),

              # Toggle Container Select Mode
              EzKey("C-v", lazy.layout.toggle_container_select_mode()),

              # Pull Out
              EzKey("o", lazy.layout.pull_out()),
              EzKey("u", lazy.layout.pull_out_to_tab()),

              # Rename Tab
              EzKey("r", lazy.layout.rename_tab()),

              # Directional commands to merge windows with their neighbor into subtabs.
              KeyChord(
                  [],
                  "m",
                  [
                      EzKey("h", lazy.layout.merge_to_subtab("left")),
                      EzKey("l", lazy.layout.merge_to_subtab("right")),
                      EzKey("j", lazy.layout.merge_to_subtab("down")),
                      EzKey("k", lazy.layout.merge_to_subtab("up")),

                      # Merge entire tabs with each other as splits
                      EzKey("S-h", lazy.layout.merge_tabs("previous")),
                      EzKey("S-l", lazy.layout.merge_tabs("next")),
                  ],
                  mode=True,
                  name="B-Merge"
              ),

              ## Directional commands for push_in() to move window inside neighbor space.
              KeyChord(
                  [],
                  "i",
                  [
                      EzKey("j", lazy.layout.push_in("down")),
                      EzKey("k", lazy.layout.push_in("up")),
                      EzKey("h", lazy.layout.push_in("left")),
                      EzKey("l", lazy.layout.push_in("right")),

                      # It's nice to be able to push directly into the deepest
                      # neighbor node when desired. The default bindings above
                      # will have us push into the largest neighbor container.
                      EzKey("S-j", lazy.layout.push_in("down", dest_selection="mru_deepest"),),
                      EzKey("S-k", lazy.layout.push_in("up", dest_selection="mru_deepest"),),
                      EzKey("S-h",lazy.layout.push_in("left", dest_selection="mru_deepest"),),
                      EzKey("S-l", lazy.layout.push_in("right", dest_selection="mru_deepest"),),
                  ],
                  mode=True,
                  name="B-Push"
              ),
          ],
          mode=False,
          name="Bonsai",
      ),
])
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
# fmt: on
#### END KEYBINDINGS ####

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

# General Layout Kwargs
layout_kwargs = dict(
    border_focus=color["aqua"],
    border_normal=color["mint"],
    border_width=border_width,
    margin=margin,
)

# Floating Window Settings
floating_layout = layout.Floating(
    **layout_kwargs,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="nsxiv"),  # nsxiv
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)

# Layouts
layouts = [
    layout.MonadTall(**layout_kwargs),
    layout.Max(**layout_kwargs),
    layout.Columns(**layout_kwargs),
    # Bonsai(
    #     **{
    #         "window.border_size": border_width,
    #         # "window.margin": margin // 3,
    #         "tab_bar.height": int(24 * gui_scale),
    #     }
    # ),
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

widget_list = [
    widget.GroupBox(
        highlight_method="line",
        highlight_color=[color["background"], color["background_light"]],
        active=color["foreground"],
        inactive=color["disabled"],
        this_current_screen_border=color["orange"],
        other_current_screen_border=color["blue"],
        this_screen_border=color["disabled"],
        other_screen_border=color["disabled"],
        urgent_border=color["red"],
    ),
    seperator_widget,
    widget_extras.CurrentLayoutIcon(
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
    widget_extras.ContinuousPoll(
        cmd="xkbmon -u", fmt="󰌌  {}", foreground=color["green"]
    ),
    seperator_widget,
    widget.Systray(icon_size=int(15 * gui_scale), padding=int(8 * gui_scale)),
    seperator_widget,
    widget.Prompt(),
    widget.Chord(foreground=color["yellow"], fmt="<{}> "),
    widget.WindowName(for_current_screen=True),
    widget_extras.Mpris2(
        format="{xesam:artist} - {xesam:title}",
        no_metadata_text="",
        paused_text="  {track}",
        playing_text="󰝚  {track}",
        poll_interval=1,
        stopped_text="󰽺",
        foreground=color["aqua"],
        # mouse_callbacks={"Button3": lazy.widget.Mpris2.toggle_player()},
    ),
    seperator_widget,
    widget.CPU(
        format="  CPU{freq_current: .2f}GHz {load_percent}%",
        foreground=color["orange"],
    ),
    seperator_widget,
    widget.Memory(format="  RAM{MemPercent: .1f}%", foreground=color["blue"]),
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
        mouse_callbacks={
            "Button2": lazy.spawn("helvum"),
            "Button3": lazy.spawn("pwvucontrol"),
        },
    ),
    seperator_widget,
    widget.TextBox("󰃰 ", foreground=color["red"]),
    widget.Clock(
        format="%Y-%m-%d %a %H:%M:%S",
        foreground=color["foreground"],
    ),
    seperator_widget,
    widget.TextBox(
        "⏻  ",
        foreground=color["red"],
        mouse_callbacks={
            "Button1": lazy.spawn(
                "rofi -show power-menu -modi power-menu:~/.config/rofi/rofi-power-menu.sh"
            ),
        },
    ),
]

if battery_widget_switch:
    battery_widget = widget.Battery(
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
    )
    widget_list.insert(-1, battery_widget)


screens = [
    Screen(
        top=bar.Bar(
            widget_list,
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
