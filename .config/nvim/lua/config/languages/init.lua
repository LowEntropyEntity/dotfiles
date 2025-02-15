---@type table<string, LanguageConfig>
local M = {}

M.go = require('config.languages.go')
M.lua = require('config.languages.lua')
M.typescript = require('config.languages.typescript')

return M
