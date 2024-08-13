local wibox = require("wibox")
local beautiful = require("beautiful")

local widget = {}

local ICON_DIR = os.getenv("HOME") .. "/.config/awesome/awesome-wm-widgets/volume-widget/icons/"

function widget.get_widget(widgets_args)
	local args = widgets_args or {}

	local font = args.font or beautiful.font
	local icon_dir = args.icon_dir or ICON_DIR

	return wibox.widget({
		{
			widget = wibox.widget.textbox(" VOL "),
		},
		{
			id = "txt",
			font = font,
			widget = wibox.widget.textbox,
		},
		{
			id = "icon",
			font = font,
			widget = wibox.widget.textbox,
		},
		layout = wibox.layout.fixed.horizontal,
		set_volume_level = function(self, new_value)
			if tonumber(new_value) < 10 then
				self:get_children_by_id("txt")[1]:set_text("_" .. new_value .. "%")
			else
				self:get_children_by_id("txt")[1]:set_text(new_value .. "%")
			end

			if self.is_muted then
				self:get_children_by_id("icon")[1]:set_text(" (Muted) ")
			else
				self:get_children_by_id("icon")[1]:set_text(" ")
			end
		end,
		mute = function(self)
			self.is_muted = true
			self:get_children_by_id("icon")[1]:set_text(" (Muted) ")
		end,
		unmute = function(self)
			self:get_children_by_id("icon")[1]:set_text(" ")
			self.is_muted = false
		end,
	})
end

return widget
