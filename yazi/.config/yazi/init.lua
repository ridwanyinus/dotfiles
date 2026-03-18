Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})
require("folder-rules"):setup()
require("relative-motions"):setup({ enter_mode = "first" })
require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})
require("recycle-bin"):setup()
