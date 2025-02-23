---@type LanguageConfig
local M = {
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
