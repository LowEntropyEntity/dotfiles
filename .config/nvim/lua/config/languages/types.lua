require('lazy.types')
require('dap')

---@class MasonConfig
---@field tools? string[] mason tools to install

---@class DapConfig
---@field mason? MasonConfig
---@field adapters table<string, dap.Adapter|function>
---@field languages string[]
---@field configurations dap.Configuration[]

---@class Dap
---@field plugin? LazyPlugin
---@field config? DapConfig

---@class LanguageConfig
---@field root_files? string[]	files to look for in root directory
---@field mason? MasonConfig
---@field dap? Dap
---@field servers? table<string, any>

local M = {}
return M
