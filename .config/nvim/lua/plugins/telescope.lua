local config = function()
	local telescope = require('telescope')
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = 'move_selection_next',
					["<C-k>"] = 'move_selection_previous',
				},
			},
		}
	})
end

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	lazy = false,
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = config
}

