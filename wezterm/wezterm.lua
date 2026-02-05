local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	default_cursor_style = "BlinkingBar",
	color_scheme = "Nord (Gogh)",
	-- font = wezterm.font("Hack Nerd Font Mono"),
	font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font Mono",
    "Nerd Fonts Symbols",
	"Devicons",
	"Noto Color Emoji"
  }),
	font_size = 16,
	warn_about_missing_glyphs=false
}

return config
