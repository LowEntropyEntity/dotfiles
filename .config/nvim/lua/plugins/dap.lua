local dapui_config = function()
	local dap, dapui = require('dap'), require('dapui')
	dapui.setup()
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
end

local dap_config = function()
	require('mason').setup()
	require('mason-nvim-dap').setup()

	local dap = require('dap.ext.vscode')
	local status, json5 = pcall(require, 'json5')
	if status then
		dap.json_decode = json5.parse
	else
		vim.notify('could not load json5', vim.log.levels.WARN)
	end
	dap.load_launchjs(nil, {})
end

return {
	{
		'jay-babu/mason-nvim-dap.nvim',
		cmd = {'DapInstall', 'DapUninstall'},
		event = 'LspAttach',
		opts = {
			ensure_installed = {},
			automatic_installation = true
		},
		config = function() end
	},
	{
		'mfussenegger/nvim-dap',
		-- cmd = {'DapInstall'},
		-- event = 'LspAttach',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			{
				'theHamsta/nvim-dap-virtual-text',
				opts = {},
			},
			{
				"Joakker/lua-json5",
				build = './install.sh',
			},
		},
		keys = {
			{ '<leader>d', '', desc = '+debug', mode = {'n', 'v'} },
			{ '<F5>', function()require('dap').continue() end, desc = 'debug' },
			{ '<leader>dd', function()require('dap').continue() end, desc = 'debug' },

			{ '<F17>', function()require('dap').terminate() end, desc = 'stop debugging' }, -- shift + F5
			{ '<F41>', function()require('dap').restart() end, desc = 'restart' }, -- ctrl + shift + F5

			{ '<F10>', function()require('dap').step_over() end, desc = 'step over' },
			{ '<F11>', function()require('dap').step_into() end, desc = 'step in' },
			{ '<F23>', function()require('dap').step_out() end, desc = 'step out' }, -- shift + F11
			{ '<leader>dj', function()require('dap').step_over() end, desc = 'step over' },
			{ '<leader>dl', function()require('dap').step_into() end, desc = 'step in' },
			{ '<leader>dh', function()require('dap').step_out() end, desc = 'step out' },

			{ '<leader>db', function()require('dap').toggle_breakpoint() end, desc = 'toggle breakpoint' },
			{ '<leader>dB', function()require('dap').set_breakpoint() end, desc = 'set breakpoint' },

			{ '<leader>dL', function()require('dap').set_breakpoint(nil, nil, vim.fn.input('log point message: ')) end, desc = 'log point' },
			{ '<leader>d:', function()require('dap').repl.open() end, desc = 'open debug console' },
		},
		config = dap_config
	},
	{
		'rcarriga/nvim-dap-ui',
		event = 'LspAttach',
		keys = {
			{ '<leader>dui', function() require('dapui').toggle({}) end, desc = 'toggle' },
			{ '<leader>de', function() require('dapui').eval() end, desc = 'evaluate', mode = { 'n', 'v' }},
		},
		config = dapui_config,
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		}
	},
}
