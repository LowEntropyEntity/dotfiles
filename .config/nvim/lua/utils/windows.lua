local M = {}

--- direction: h, j, k, l
function M.swap_buffer(direction)
	local currentWindow = vim.api.nvim_get_current_win()
	local currentBuffer = vim.api.nvim_get_current_buf()

	vim.cmd('wincmd ' .. direction)

	local targetWindow = vim.api.nvim_get_current_win()
	if targetWindow == currentWindow then
		return
	end

	local targetBuffer = vim.api.nvim_get_current_buf()

	vim.api.nvim_win_set_buf(targetWindow, currentBuffer)
	vim.api.nvim_win_set_buf(currentWindow, targetBuffer)

	vim.api.nvim_set_current_win(targetWindow)
end

return M
