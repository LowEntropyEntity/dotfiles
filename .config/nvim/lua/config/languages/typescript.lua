---@type LanguageConfig
local M = {
	root_files = {
		'package.json',
		'tsconfig.json'
	},
	mason = {
		tools = {
			'eslint-lsp',
			'vtsls',
		}
	},
	dap = {
		config= {
			mason = {
				tools = {
					'js-debug-adapter',
				},
			},
			adapters = {
				node = function(cb, config)
					if config.type == 'node' then
						config.type = 'pwa-node'
					end
					local nativeAdapter = require('dap').adapters['pwa-node']
					if type(nativeAdapter) == 'function' then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end,
				['pwa-node'] = {
					type = 'server',
					host = 'localhost',
					port = '${port}',
					executable = {
						command = vim.fn.stdpath('data') .. '/mason/bin/js-debug-adapter',
						args = {
							'${port}',
						},
					},
				}
			},
			languages = {
				'javascript',
				'javascriptreact',
				'javascript.jsx',
				'typescript',
				'typescriptreact',
				'typescript.tsx',
			},
			configurations = {
				{
					type = 'pwa-node',
					request = 'launch',
					name = 'launch file',
					program = '${file}',
					cwd = '${workspaceFolder}',
				},
			},
		}
	},
	servers = {
		vtsls = {
			filetypes = {
				'javascript',
				'javascriptreact',
				'javascript.jsx',
				'typescript',
				'typescriptreact',
				'typescript.tsx',
			},
			settings = {
				complete_function_calls = true,
				vtsls = {
					enableMoveToFileCodeAction = true,
					autoUseWorkspaceTsdk = true,
					experimental = {
						maxInlayHintLength = 30,
						completion = {
							enableServerSideFuzzyMatch = true,
						},
					},
				},
				typescript = {
					updateImportsOnFileMove = {
						enabled = 'always'
					},
					suggest = {
						completeFunctionCalls = true,
					},
					inlayHints = {
						enumMemberValues = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						parameterNames = { enabled = 'literals' },
						parameterTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						variableTypes = { enabled = false },
					}
				}
			}
		}
	}
}

return M
