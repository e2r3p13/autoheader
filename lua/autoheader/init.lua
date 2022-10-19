local M = {}

local header_template = [[
/* %s
 *
 * %s
 *
 * created: %04d/%02d/%02d - %s <%s>
 * updated: %04d/%02d/%02d - %s <%s>
 */
]]
local header_line_count = 7
local update_line_template = " * updated: %04d/%02d/%02d - %s <%s>"
local default_description = "Insert file description here"
local api = vim.api

function M.AddHeader()
	time = os.date("*t")

	-- TODO: Use the project relative path here
	filename = vim.fn.expand("%")
	-- TOTO: Use first arg instead of default description if provided
	description = "Insert file description here"

	day = time.day
	month = time.month
	year = time.year

	name = vim.fn.system('echo -n $(git config --global user.name)')
	email = vim.fn.system('echo -n $(git config --global user.email)')

	fmtstr = string.format(header_template, filename, description, year, month, day, name, email, year, month, day, name, email)

	if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
		vim.notify("This file is read only")
        return
    end

	lines = {}
	for line in string.gmatch(fmtstr, "([^".."\n".."]+)") do
		table.insert(lines, line)
	end
	api.nvim_buf_set_lines(0, 0, 0, 0, lines);

end

function M.UpdHeader()
	time = os.date("*t")

	day = time.day
	month = time.month
	year = time.year

	name = vim.fn.system('echo -n $(git config --global user.name)')
	email = vim.fn.system('echo -n $(git config --global user.email)')

	fmtstr = string.format(update_line_template, year, month, day, name, email)

	if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
		vim.notify("This file is read only")
        return
    end

    if vim.fn.line("$") < header_line_count then
		vim.notify("There is no header to update")
		return
	end

	-- TODO: Make sure the header is present before updating
	api.nvim_buf_set_lines(0, 5, 6, 1, {fmtstr});
end

return M
