local M = {}

local win_id, buf_id

vim.api.nvim_set_hl(0, "SearchNotifBody", { fg = "#333333", bg = "#FA8419" })
vim.api.nvim_set_hl(0, "SearchNotifBorder", { fg = "#FA8419" })

local function search_status()
	if vim.v.hlsearch == 0 then
		return ""
	end
	local last_search = vim.fn.getreg("/")
	if not last_search or last_search == "" then
		return ""
	end
	local searchcount = vim.fn.searchcount({ maxcount = 0 })
	return '"' .. last_search .. '" ' .. searchcount.current .. "/" .. searchcount.total
end

function M.hide()
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
	end
	win_id = nil
end

local function show(text)
	if not (buf_id and vim.api.nvim_buf_is_valid(buf_id)) then
		buf_id = vim.api.nvim_create_buf(false, true)
		vim.bo[buf_id].buftype = "nofile"
	end
	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { " " .. text .. " " })

	local width = vim.fn.strdisplaywidth(text) + 2
	local height = 1
	-- Fixed bottom-right position, independent of Snacks' notifier layout.
	local row = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0) - height - 2
	local col = vim.o.columns - width - 1

	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_set_config(win_id, { relative = "editor", row = row, col = col, width = width, height = height })
	else
		win_id = vim.api.nvim_open_win(buf_id, false, {
			relative = "editor",
			row = row,
			col = col,
			width = width,
			height = height,
			style = "minimal",
			border = "rounded",
			title = " Search ",
			title_pos = "left",
			focusable = false,
			noautocmd = true,
			zindex = 200,
		})
		vim.wo[win_id].winhighlight =
			"Normal:SearchNotifBody,FloatBorder:SearchNotifBorder,Search:SearchNotifBody,CurSearch:SearchNotifBody"
	end
end

local function update_search_notify()
	local msg = search_status()
	if msg == "" then
		M.hide()
	else
		show(msg)
	end
end

vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = { "/", "?" },
	callback = function()
		vim.schedule(function()
			update_search_notify()
			vim.cmd("echo ''")
		end)
	end,
})

vim.keymap.set("n", "n", function()
	vim.cmd("normal! n")
	update_search_notify()
end)
vim.keymap.set("n", "N", function()
	vim.cmd("normal! N")
	update_search_notify()
end)

return M
