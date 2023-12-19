local gitsigns_config = function()
	local gitsigns = require('gitsigns')
	gitsigns.setup()

	vim.keymap.set('n', '<leader>blame', function() require('gitsigns').toggle_current_line_blame() end, { desc = 'gitsigns: toggle blame' })
end

return {
	{
		'tpope/vim-fugitive',
		cmd = 'Git',
		keys = {
			{ '<leader>gs', vim.cmd.Git, desc = 'fugitive: git status' }
		}
	},
	{
		'lewis6991/gitsigns.nvim',
		event = 'VeryLazy',
		config = gitsigns_config
	}
}
