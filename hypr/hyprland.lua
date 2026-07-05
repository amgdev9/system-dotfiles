hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.on("hyprland.start", function () 
   hl.exec_cmd("waybar")
   hl.exec_cmd("hypridle")
   hl.exec_cmd("swaybg -i /home/amg/.config/hypr/wallpaper.jpg -m fill")
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZEb", "24")
hl.env("GTK_THEME", "Adwaita:dark")

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle"
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true
    },
    xwayland = {
        enabled = true
    },
    decoration = {
        rounding = 0,
        active_opacity = 1,
        inactive_opacity = 1,
        shadow = {
            enabled = false 
        },
        blur = {
            enabled = false 
        }
    },
    animations = {
        enabled = false
    },
    dwindle = {
        preserve_split = true 
    },
    master = {
        new_status = "master"
    },
    misc = {
        force_default_wallpaper = 0, 
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_anr_dialog = false,
        middle_click_paste = false
    },
    input = {
        kb_layout = "es",
        kb_options = "caps:swapescape",
        follow_mouse = 1,
        sensitivity = 0,
        repeat_delay = 350,
        touchpad = {
            natural_scroll = false
        }
    }
})

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("wofi --show drun --insensitive"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind(mainMod .. " + plus", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen(1))

local clearCmd = 'printf "" | wl-copy && printf "" | wl-copy --primary && hyprctl notify -1 5000 "rgb(ff1ea3)" "fontsize:24 Clipboard cleared!"'
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(clearCmd))

-- Fix file dialogs being too big
hl.window_rule({
    name = "maximize-brave",
    match = {
        class = "brave-origin|brave|blender",
    },
    maximize = true,
})

-- Development windows go to workspace 2
hl.window_rule({
    name = "dev-window",
    match = {
        class = "dev-window"
    },
    workspace = "2 silent",
})
