local M = {}

local function retab_range_or_buffer()
	local startPosition = vim.fn.getpos("v")
	local endPosition = vim.fn.getpos(".")
	local startLine, startColumn = startPosition[2], startPosition[3]
	local endLine, endColumn = endPosition[2], endPosition[3]

	if (startLine == endLine) and (startColumn == endColumn) then -- no selection
		vim.cmd('%retab!')
	else
		vim.cmd(startLine .. ',' .. endLine .. 'retab!')
	end
end

function M.spaces_to_tabs()
	local original = vim.o.tabstop
	local count = (vim.v.count ~= 0) and vim.v.count or original

	vim.o.tabstop = count

	retab_range_or_buffer()

	vim.o.tabstop = original
end

function M.tabs_to_spaces()
	local original_tabstop = vim.o.tabstop
	local original_shiftwidth = vim.o.shiftwidth
	local original_expandtab = vim.o.expandtab
	local count = (vim.v.count ~= 0) and vim.v.count or original_shiftwidth

	vim.o.tabstop = count
	vim.o.shiftwidth = count
	vim.o.expandtab = true

	retab_range_or_buffer()

	vim.o.tabstop = original_tabstop
	vim.o.shiftwidth = original_shiftwidth
	vim.o.expandtab = original_expandtab
end

return M
