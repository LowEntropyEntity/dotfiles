local config = function()
	local dap_go = require('dap-go')
	dap_go.setup({})
end

return {
	'leoluz/nvim-dap-go',
	event = { 'BufEnter *.go' },
	config = config
}
