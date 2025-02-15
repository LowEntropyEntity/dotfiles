local gitsigns_config = function()
	local gitsigns = require('gitsigns')
	gitsigns.setup({
		current_line_blame = true,
		word_diff = true
	})

	vim.keymap.set('n', '<leader>gbb', function() gitsigns.toggle_current_line_blame() end, { desc = 'toggle buffer blame inline' })
	vim.keymap.set('n', '<leader>gbB', function() gitsigns.blame() end, { desc = 'buffer blame' })
	vim.keymap.set('n', '<leader>glb', function() gitsigns.blame_line({full = true}) end, { desc = 'line blame' })

	vim.keymap.set('n', '<leader>ghd', function() gitsigns.preview_hunk() end, { desc = 'hunk diff' })
	vim.keymap.set('n', '<leader>gbd', function() gitsigns.diffthis() end, { desc = 'buffer diff' })
	vim.keymap.set('n', '<leader>gbD', function() gitsigns.diffthis('~') end, { desc = 'buffer diff HEAD' })

	vim.keymap.set('n', '<leader>gbs', function() gitsigns.stage_buffer() end, { desc = 'buffer stage' })
	vim.keymap.set('n', '<leader>ghs', function() gitsigns.stage_hunk() end, { desc = 'toggle hunk stage' })
end

return {
	'lewis6991/gitsigns.nvim',
	event = 'VeryLazy',
	config = gitsigns_config
}
