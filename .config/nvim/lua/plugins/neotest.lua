local config = function()
	local neotest = require('neotest')
	neotest.setup({})

	vim.keymap.set('n', '<leader>tof', function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = 'neotest: show output float' })
	vim.keymap.set('n', '<leader>top', function() neotest.output_panel.toggle() end, { desc = 'neotest: show output panel' })
	vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = 'neotest: toggle summary' })
	vim.keymap.set('n', '<leader>tw', function() neotest.watch.toggle(vim.fn.expand('%')) end, { desc = 'neotest: toggle watch' })
	vim.keymap.set('n', '<leader>topc', function() neotest.output_panel.clear() end, { desc = 'neotest: clear output panel' })
	vim.keymap.set('n', '<leader>tcr', function() neotest.run.run() end, { desc = 'neotest: run test case' })
	vim.keymap.set('n', '<leader>tcd', function() neotest.run.run({ strategy = 'dap' }) end, { desc = 'neotest: debug test case' })
	vim.keymap.set('n', '<leader>tca', function() neotest.run.attach() end, { desc = 'neotest: attach test case' })
	vim.keymap.set('n', '<leader>tcrr', function() neotest.run.run_last() end, { desc = 'neotest: run last test case' })
	vim.keymap.set('n', '<leader>tcdd', function() neotest.run.run_last({ strategy = 'dap' }) end, { desc = 'neotest: debug last test case' })
	vim.keymap.set('n', '<leader>tar', function() neotest.run.run(vim.uv.cwd()) end, { desc = 'neotest: run all tests' })
	vim.keymap.set('n', '<leader>tfr', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'neotest: run all tests in file' })
end

return {
	'nvim-neotest/neotest',
	event = 'LspAttach',
	dependencies = {
		'nvim-neotest/nvim-nio',
		'nvim-lua/plenary.nvim',
		'antoinemadec/FixCursorHold.nvim',
		'nvim-treesitter/nvim-treesitter'
	},
}
