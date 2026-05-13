local scrPath = (os.getenv("HOME") or "") .. "/.config/hypr/Scripts"
local mainMod = "SUPER"
local TERMINAL = "kitty"
local EDITOR = "code"
local EXPLORER = "thunar"
local BROWSER = scrPath .. "/browser-launcher.sh"

-- Application launchers
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(TERMINAL))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(EXPLORER))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(EDITOR))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(BROWSER))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd("qs -c noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("qs -c noctalia-shell ipc call lockScreen lock"))
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd("qs -c noctalia-shell ipc call settings toggle"))
hl.bind(mainMod .. " + H",      hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:keybind-cheatsheet toggle"))
hl.bind(mainMod .. " + K",      hl.dsp.exec_cmd("qs -c noctalia-shell ipc call plugin:hyprland-keybinds toggle"))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd("steam"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Workspace navigation (monitor-relative)
hl.bind(mainMod .. " + tab",   hl.dsp.exec_cmd(scrPath .. "/workspace.sh"))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Cycle windows
hl.bind("ALT + tab", hl.dsp.window.cycle_next())

-- Resize active window (keyboard)
hl.bind(mainMod .. " + SHIFT + right", function() hl.exec_cmd("hyprctl dispatch resizeactive 30 0") end)
hl.bind(mainMod .. " + SHIFT + left",  function() hl.exec_cmd("hyprctl dispatch resizeactive -30 0") end)
hl.bind(mainMod .. " + SHIFT + up",    function() hl.exec_cmd("hyprctl dispatch resizeactive 0 -30") end)
hl.bind(mainMod .. " + SHIFT + down",  function() hl.exec_cmd("hyprctl dispatch resizeactive 0 30") end)

-- Move active window (float) or swap tiled
hl.bind(mainMod .. " + SHIFT + CTRL + left",  function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive -30 0 || hyprctl dispatch movewindow l'") end)
hl.bind(mainMod .. " + SHIFT + CTRL + right", function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 30 0 || hyprctl dispatch movewindow r'") end)
hl.bind(mainMod .. " + SHIFT + CTRL + up",    function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 0 -30 || hyprctl dispatch movewindow u'") end)
hl.bind(mainMod .. " + SHIFT + CTRL + down",  function() hl.exec_cmd("bash -c 'grep -q true <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive 0 30 || hyprctl dispatch movewindow d'") end)

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m window"))
hl.bind("ALT + PRINT",         hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m output"))
hl.bind("SHIFT + PRINT",       hl.dsp.exec_cmd("HYPRSHOT_DIR=~/Pictures/Screenshots hyprshot -m region"))
hl.bind(mainMod .. " + A",     hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | satty --filename - --output-filename ~/Pictures/Screenshots/Screenshot-$(date '+%Y%m%d-%H:%M:%S').png"))

-- Workspace switching and window-to-workspace
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Relative workspace navigation
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.focus({ workspace = "empty" }))

-- Move window to relative workspace
hl.bind(mainMod .. " + CTRL + ALT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + ALT + left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Mouse scroll workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window management
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + X",         hl.dsp.window.resize())

-- Media keys
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"),         { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"),         { locked = true })

return true
