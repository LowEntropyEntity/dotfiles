local cmp_config = function()
	local cmp = require('cmp')
	cmp.setup({
		sources = {
			{name = 'nvim_lsp'},
		},
		mapping = cmp.mapping.preset.insert({
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<C-y>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),
		}),
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
	})
end

local lsp_config = function()
	local lsp_defaults = require('lspconfig').util.default_config

	-- add cmp_nvim_lsp capabilities settings to lspconfig
	-- this should be executed before you configure any language server
	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require('cmp_nvim_lsp').default_capabilities()
	)

	local telescope = require('telescope.builtin')

	-- LspAttach is where you enable features that only work
	-- if there is a language server active in the file
	vim.api.nvim_create_autocmd('LspAttach', {
		desc = 'LSP actions',
		callback = function(event)
			local function opts(desc)
				return { buffer = event.buf, desc = desc }
			end

			vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts('lsp: hover'))
			vim.keymap.set('n', '<F12>', function() vim.lsp.buf.definition() end, opts('lsp: go to definition'))
			vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts('lsp: go to definition'))
			vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts('lsp: go to declaration'))
			vim.keymap.set('n', '<F36>', function() telescope.lsp_implementations() end, opts('lsp: find all implementations')) -- ctrl + F12
			vim.keymap.set('n', 'gi', function() telescope.lsp_implementations() end, opts('lsp: find all implementations'))
			vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts('lsp: go to type definition'))
			vim.keymap.set('n', '<F24>', function() telescope.lsp_references() end, opts('lsp: find all references')) -- shift + F12
			vim.keymap.set('n', 'gr', function() telescope.lsp_references() end, opts('lsp: find all references'))
			vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts('lsp: signature'))
			vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts('lsp: rename symbol'))
			vim.keymap.set('n', '<leader>rename', function() vim.lsp.buf.rename() end, opts('lsp: rename symbol'))
			vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts('lsp: format document'))
			vim.keymap.set('n', '<leader>!', function() vim.lsp.buf.code_action() end, opts('lsp: code actions'))
			vim.keymap.set('n', '<leader>?', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts('lsp: toggle inlay hints'))
		end,
	})
	require('mason-lspconfig').setup({
		ensure_installed = {},
		handlers = {
			-- this first function is the "default handler"
			-- it applies to every language server without a "custom handler"
			function(server_name)
				require('lspconfig')[server_name].setup({})
			end,
		}
	})
end

return {
	{
		'williamboman/mason.nvim',
		opts = {},
		lazy = false
	},
	{
		'neovim/nvim-lspconfig',
		opts = {
			inlay_hints = { enabled = true },
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							hint = { enable = true }
						}
					}
				},
				tsserver = {
					settings = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = 'all',
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					}
				}
			}
		},
		cmd = {'LspInfo', 'LspInstall', 'LspStart' },
		event = {'BufReadPre', 'BufNewFile'},
		config = lsp_config,
		dependencies = {
			{
				{'hrsh7th/cmp-nvim-lsp'},
				{'williamboman/mason.nvim'},
				{'williamboman/mason-lspconfig.nvim'},
			},
		},
		init = function()
			-- reserve a space in the gutter
			-- this will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = 'yes'
		end,
	},
	-- autocomplete
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		config = cmp_config,
	}
}

