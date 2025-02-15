---@type LanguageConfig
local M = {
	mason = {
		tools = {
			'lua-language-server'
		}
	},
	servers = {
		settings = {
			Lua = {
				hint = { enable = true }
			}
		}
	}
}

return M
