return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	opts = {
	},
	keys = {
		{ '<leader><space>?', function() require('which-key').show({ global = false }) end, desc = 'which-key: show keymaps' }
	},
	dependencies = {
		'echasnovski/mini.icons'
	}
}
