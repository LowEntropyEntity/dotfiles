return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		lazy = false
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					'clangd',
					'cmake',
					'dockerls',
					'docker_compose_language_service',
					'golangci_lint_ls',
					'gopls',
					'gradle_ls',
					'html',
					'jsonls',
					'quick_lint_js',
					'tsserver',
					'ltex',
					'lua_ls',
					'marksman',
					'pyright',
					'rust_analyzer',
					'yamlls'
				}
			})
		end,
		lazy = false
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").lua_ls.setup({})
		end,
		lazy = false
	}
}

