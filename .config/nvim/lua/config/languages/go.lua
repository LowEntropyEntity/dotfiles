---@type LanguageConfig
local M = {
	dap = {
		'leoluz/nvim-dap-go'
	},
	mason = {
		tools = {
			'delve',
			'gopls'
		}
	},
	root_files = {
		'go.mod',
		'go.sum'
	},
}

return M
