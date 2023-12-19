local dapui_config = function()
	local dap, dapui = require('dap'), require('dapui')
	dapui.setup({})
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
	vim.keymap.set('n', '<leader>du', function() require('dapui').toggle({}) end, { desc = 'dap-ui: toggle' })
	vim.keymap.set({ 'n', 'v' }, '<leader>de', function() require('dapui').eval() end, { desc = 'dap-ui: evaluate'})
end

local dap_config = function()
	vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'dap: debug' } )
	vim.keymap.set('n', '<leader>dbg', function() require('dap').continue() end, { desc = 'dap: debug' } )

	vim.keymap.set('n', '<F17>', function() require('dap').terminate() end, { desc = 'dap: stop debugging' } ) -- shift + F5
	vim.keymap.set('n', '<F41>', function() require('dap').restart() end, { desc = 'dap: restart' } ) -- ctrl + shift + F5

	vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'dap: step over' } )
	vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'dap: step in' } )
	vim.keymap.set('n', '<F23>', function() require('dap').step_out() end, { desc = 'dap: step out' } ) -- shift + F11
	vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end, { desc = 'dap: step over' } )
	vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'dap: step in' } )
	vim.keymap.set('n', '<leader>do', function() require('dap').step_out() end, { desc = 'dap: step out' } )

	vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'dap: toggle breakpoint' } )
	vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint() end, { desc = 'dap: set breakpoint' } )

	vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('log point message: ')) end, { desc = 'dap: log point' } )
	vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end, { desc = 'dap: open debug console' } )
	vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'dap: run last' } )
end

return {
	{
		'mfussenegger/nvim-dap',
		event = 'LspAttach',
		config = dap_config
	},
	{
		'rcarriga/nvim-dap-ui',
		event = 'LspAttach',
		config = dapui_config,
		dependencies = {
			'nvim-neotest/nvim-nio'
		}
	}
}
