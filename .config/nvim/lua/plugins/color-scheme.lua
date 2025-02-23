local catppuccin_config = function()
	local in_dev_container = (os.getenv("DEV_CONTAINER") ~= nil)
	local flavor = 'mocha'
	if in_dev_container then
		flavor = 'frappe'
	end

	local catppuccin = require('catppuccin')
	catppuccin.setup({
		flavour = flavor, -- auto, latte, frappe, macchiato, mocha
		transparent_background = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = '',
			},
		},
	})
	vim.cmd.colorscheme 'catppuccin'
end

return {
	'catppuccin/nvim',
	name = 'catppuccin',
	lazy = false,
	priority = 1000,
	config = catppuccin_config
}
