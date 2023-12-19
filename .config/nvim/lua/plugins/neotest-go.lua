local config = function()
	local neotest_golang_opts = {}
	require('neotest').setup({
		adapters = {
			require('neotest-golang')(neotest_golang_opts),
		},
	})
end

return {
	'fredrikaverpil/neotest-golang',
	event = { 'BufEnter *.go' },
	config = config
}
