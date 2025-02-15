local config = function()
	local configs = require('nvim-treesitter.configs')

	configs.setup({
		ensure_installed = {},
		auto_install = false,
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		ignore_install = {},
		modules = {}
	})
end

return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = config,
	lazy = false
}

