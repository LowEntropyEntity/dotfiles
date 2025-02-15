local config = function()
	local neotest = require('neotest')
	neotest.setup({})

	vim.keymap.set('n', '<leader>tuiof', function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = 'show output float' })
	vim.keymap.set('n', '<leader>tuiop', function() neotest.output_panel.toggle() end, { desc = 'show output panel' })
	vim.keymap.set('n', '<leader>tuis', function() neotest.summary.toggle() end, { desc = 'toggle summary' })
	vim.keymap.set('n', '<leader>tuiw', function() neotest.watch.toggle(vim.fn.expand('%')) end, { desc = 'toggle watch' })
	vim.keymap.set('n', '<leader>tuix', function() neotest.output_panel.clear() end, { desc = 'clear output panel' })
	vim.keymap.set('n', '<leader>tcr', function() neotest.run.run() end, { desc = 'run' })
	vim.keymap.set('n', '<leader>tcd', function() neotest.run.run({ strategy = 'dap', suite = false }) end, { desc = 'debug' })
	vim.keymap.set('n', '<leader>tca', function() neotest.run.attach() end, { desc = 'attach' })
	vim.keymap.set('n', '<leader>tcrr', function() neotest.run.run_last() end, { desc = 'run last' })
	vim.keymap.set('n', '<leader>tcdd', function() neotest.run.run_last({ strategy = 'dap', suite = false }) end, { desc = 'debug' })
	vim.keymap.set('n', '<leader>tar', function() neotest.run.run(vim.uv.cwd()) end, { desc = 'run' })
	vim.keymap.set('n', '<leader>tfr', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'run' })
	vim.keymap.set('n', '<leader>tfd', function() neotest.run.run({vim.fn.expand('%'), strategy = 'dap', suite = false}) end, { desc = 'debug' })
end

return {
	{
		'nvim-neotest/neotest',
		event = 'LspAttach',
		dependencies = {
			'nvim-neotest/nvim-nio',
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter'
		},
		config = config
	},
	{
		'rouge8/neotest-rust',
		enabled = false,
		ft = 'rust',
		dependencies = { 'nvim-neotest/neotest' },
	},
	{
		'haydenmeade/neotest-jest',
		enabled = false,
		ft = {
			'typescript',
			-- 'javascript'
		},
		dependencies = { 'nvim-neotest/neotest' },
	},
	{
		'adrigzr/neotest-mocha',
		ft = {
			'typescript',
			-- 'javascript'
		},
		dependencies = { 'nvim-neotest/neotest' },
	},
	{
		'fredrikaverpil/neotest-golang',
		enabled = false,
		ft = {
			'go',
			'gomod',
			'gosum',
		},
	}
}
