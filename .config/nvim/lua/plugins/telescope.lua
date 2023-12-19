local config = function()
	local telescope = require('telescope')
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					['<C-j>'] = 'move_selection_next',
					['<C-k>'] = 'move_selection_previous',
					['<C-h>'] = 'which_key'
				},
			},
		},
		pickers = {
		  -- Default configuration for builtin pickers goes here:
		  -- picker_name = {
		  -- 	picker_config_key = value,
		  -- 	...
		  -- }
		  -- Now the picker_config_key will be applied every time you call this
		  -- builtin picker
		},
		extensions = {
		  -- Your extension configuration goes here:
		  -- extension_name = {
		  -- 	extension_config_key = value,
		  -- }
		  -- please take a look at the readme of the extension you want to configure
		}
	})
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = config,
	keys = {
		{ '<C-p>', function() require('telescope.builtin').find_files() end, desc = 'telescope: find files' },
		{ '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'telescope: find files' },
		{ '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'telescope: grep' },
		{ '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'telescope: find buffers' }
	}
}

