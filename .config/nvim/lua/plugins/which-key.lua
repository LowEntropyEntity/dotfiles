return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	opts = {
		preset = 'helix',
		defaults = {},
		spec = {
			{
				mode = { 'n', 'v' },
				-- { '<leader><tab>', group = 'tabs' },
				{ '<leader>b', group = 'buffer' },
				{ '<leader>c', group = 'code' },
				{ '<leader>cg', group = 'go to' },
				{ '<leader>cf', group = 'find' },
				{ '<leader>cr', group = 'refactor' },
				{ '<leader>d', group = 'debug' },
				-- { '<leader>dp', group = 'profiler' },
				{ '<leader>f', group = 'find' },
				{ '<leader>fa', group = 'all (include hidden)' },
				{ '<leader>g', group = 'git' },
				{ '<leader>gb', group = 'buffer' },
				{ '<leader>gh', group = 'hunk' },
				{ '<leader>gl', group = 'line' },
				-- { '<leader>q', group = 'quit/session' },
				-- { '<leader>s', group = 'search' },
				{ '<leader>t', group = 'test' },
				{ '<leader>tc', group = 'case' },
				{ '<leader>tf', group = 'file' },
				{ '<leader>ta', group = 'all' },
				{ '<leader>tui', group = 'ui' },
				{ '<leader>ui', group = 'ui' },
				-- { '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
				-- { '[', group = 'prev' },
				-- { ']', group = 'next' },
				-- { 'g', group = 'goto' },
				-- { 'gs', group = 'surround' },
				-- { 'z', group = 'fold' },
				-- {
				-- 	'<leader>b',
				-- 	group = 'buffer',
				-- 	expand = function()
				-- 		return require('which-key.extras').expand.buf()
				-- 	end,
				-- },
				-- {
				-- 	'<leader>w',
				-- 	group = 'windows',
				-- 	proxy = '<c-w>',
				-- 	expand = function()
				-- 		return require('which-key.extras').expand.win()
				-- 	end,
				-- },
				-- -- better descriptions
				-- { 'gx', desc = 'Open with system app' },
			},
		},
	},
	keys = {
		{ '<leader><space>?', function() require('which-key').show({ global = false }) end, desc = 'which-key: show keymaps' }
	},
	dependencies = {
		'echasnovski/mini.icons'
	}
}
