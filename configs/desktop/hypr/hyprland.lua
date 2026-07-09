-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

local colors = require("confs.macchiato")

require("confs.monitor")
require("confs.input")
require("confs.keys")
require("confs.windowrules")
require("confs.environment")
-- require("confs.electron-flickering-fix")
-- require("confs.intellij-flickering-fix")

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper &")
  hl.exec_cmd("hypridle &")
  hl.exec_cmd("mako &")
  hl.exec_cmd("waybar --config ~/.config/waybar/left.jsonc")
  hl.exec_cmd("waybar --config ~/.config/waybar/right.jsonc")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-macchiato-lavender-cursors")

hl.config({
  general = {
    gaps_in = 3,
    gaps_out = 5,
    border_size = 3,

    col = {
      active_border = {
        colors = {
          "rgba(" .. colors.mauveAlpha .. "ee)",
          "rgba(" .. colors.lavenderAlpha .. "ee)",
        },
        angle = 30,
      },
      inactive_border = "rgba(" .. colors.overlay0Alpha .. "aa)",
    },

    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  group = {
    insert_after_current = true,
    focus_removed_window = true,
    merge_groups_on_drag = true,
    merge_groups_on_groupbar = true,
    group_on_movetoworkspace = true,

    col = {
      border_active = {
        colors = {
          "rgba(" .. colors.mauveAlpha .. "ee)",
          "rgba(" .. colors.lavenderAlpha .. "ee)",
        },
        angle = 30,
      },
      border_inactive = "rgba(" .. colors.overlay0Alpha .. "aa)",
      border_locked_active = "rgba(" .. colors.peachAlpha .. "ee)",
      border_locked_inactive = "rgba(" .. colors.surface2Alpha .. "aa)",
    },

    groupbar = {
      enabled = false,
      render_titles = false,
      scrolling = true,
      stacked = false,
      height = 4,
      indicator_height = 3,
      indicator_gap = 0,
      gaps_in = 0,
      gaps_out = 0,
      keep_upper_gap = false,
      gradients = false,
      rounding = 0,
      round_only_edges = true,
      col = {
        active = "rgba(" .. colors.lavenderAlpha .. "ee)",
        inactive = "rgba(" .. colors.overlay0Alpha .. "aa)",
        locked_active = "rgba(" .. colors.peachAlpha .. "ee)",
        locked_inactive = "rgba(" .. colors.surface2Alpha .. "aa)",
      },
    },
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },

  debug = {
    disable_logs = false,
    enable_stdout_logs = false,
    disable_time = false,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.6, bezier = "quick" })
hl.animation({ leaf = "fadeSwitch", enabled = false, speed = 1, bezier = "linear" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.0, bezier = "quick", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 0.8, bezier = "quick", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.0, bezier = "quick", style = "fade" })

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})
