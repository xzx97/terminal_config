require("git"):setup()
require("smart-enter"):setup {
		open_multi = true,
}

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}

THEME.git = THEME.git or {}
THEME.git.modified = ui.Style():fg("blue")
THEME.git.deleted = ui.Style():fg("red"):bold()
