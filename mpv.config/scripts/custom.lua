local function show_chapter()
	local chapters = mp.get_property_number("chapter-list/count", 0)
	local current = mp.get_property_number("chapter", -1)
	if chapters > 0 and current >= 0 then
		mp.osd_message(string.format("Chapter %d/%d", current + 1, chapters), 2)
	end
end

mp.add_key_binding("META+RIGHT", "next-chapter-osd", function()
	mp.commandv("add", "chapter", 1)
	show_chapter()
end)

mp.add_key_binding("META+LEFT", "prev-chapter-osd", function()
	mp.commandv("add", "chapter", -1)
	show_chapter()
end)
