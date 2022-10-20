local M = {}

local header_template = [[
// SPDX-FileCopyrightText: CGL-KFS
// SPDX-License-Identifier: BSD-3-Clause
--
/* %s
 *
 * %s
 *
 * created: %s - %s <%s>
 * updated: %s - %s <%s>
 */
--
--
]]

local update_line_template = " * updated: %s - %s <%s>"
local default_description = "Insert file description here"

function M.Setup()
	vim.api.nvim_exec([[
		:autocmd BufWritePost * UpdHeader
	]], false)
end

local function get_header_information()
	spdx = {'// SPDX-FileCopyrightText: CGL-KFS', '// SPDX-License-Identifier: BSD-3-Clause'}
	header = vim.api.nvim_buf_get_lines(0, 0, 15, false)

	if #header < 2 or spdx[1] ~= header[1] or spdx[2] ~= header[2] then
		return false, 0
	end

	for i, line in ipairs(header) do
		if string.sub(line, 1, string.len(" * updated: ")) == " * updated: " then
			return true, i
		end
	end
	return true, 0
end

function M.AddHeader()
	-- Check that the file is writeable
	if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
		vim.notify("This file is read only")
        return
    end

	-- Assert no header is present
	if get_header_information() then
		vim.notify("A header is already present")
		return
	end

	-- Get the information to fill the header
	date = os.date('%Y/%m/%d')

	filename = vim.fn.expand("%")
	description = "Insert file description here"

	name = vim.fn.system('echo -n $(git config --global user.name)')
	email = vim.fn.system('echo -n $(git config --global user.email)')

	-- Build the header
	header = string.format(header_template, filename, description, date, name, email, date, name, email)

	-- Convert it into a table usable by nvim_buf_set_text
	lines = {}
	for line in string.gmatch(header, "([^".."\n".."]+)") do
		if line == "--" then
			table.insert(lines, "")
		else
			table.insert(lines, line)
		end
	end
	
	-- Insert the header on top of the file
	vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, lines);
end

function M.UpdHeader()
	-- Check that the file is writeable
	if not vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable") then
		vim.notify("This file is read only")
        return
    end

	-- Assert the header is present
	present, update_line_index = get_header_information()
	if not present then
		return
	end

	-- Get the information to fill the update line
	date = os.date('%Y/%m/%d')
	name = vim.fn.system('echo -n $(git config --global user.name)')
	email = vim.fn.system('echo -n $(git config --global user.email)')

	-- Build the update line
	update_line = string.format(update_line_template, date, name, email)

	-- Change the update line
	vim.api.nvim_buf_set_lines(0, update_line_index - 1, update_line_index, 1, {update_line});
end

return M
