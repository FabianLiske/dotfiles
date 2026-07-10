local mainMod = "SUPER"
local leftMonitorDescription = "Samsung Electric Company Odyssey G60SD HNBY100467"
local ultrawideDescription = "Samsung Electric Company Odyssey G93SD HNTL101430"

local function monitorName(description, fallback)
  for _, monitor in ipairs(hl.get_monitors()) do
    if monitor.description == description then
      return monitor.name
    end
  end

  return fallback
end

local function leftMonitorName()
  return monitorName(leftMonitorDescription, "HDMI-*")
end

local function ultrawideMonitorName()
  return monitorName(ultrawideDescription, "DP-*")
end

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("wofi --conf ~/.config/wofi/config --style ~/.config/wofi/macchiato.css"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.group.next())
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill waybar; waybar --config ~/.config/waybar/left.jsonc & waybar --config ~/.config/waybar/right.jsonc &"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("hyprctl reload"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ into_or_create_group = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ into_or_create_group = "right" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + TAB", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.group.prev())

hl.bind(mainMod .. " + SHIFT + left", function()
  hl.dispatch(hl.dsp.window.move({ monitor = leftMonitorName(), follow = true }))
end)
hl.bind(mainMod .. " + SHIFT + right", function()
  hl.dispatch(hl.dsp.window.move({ monitor = ultrawideMonitorName(), follow = true }))
end)
hl.bind(mainMod .. " + CTRL + SHIFT + left", function()
  hl.dispatch(hl.dsp.focus({ monitor = leftMonitorName() }))
end)
hl.bind(mainMod .. " + CTRL + SHIFT + right", function()
  hl.dispatch(hl.dsp.focus({ monitor = ultrawideMonitorName() }))
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
