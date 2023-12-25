local cmp_config = function()
	local cmp = require('cmp')
	local cmp_action = require('lsp-zero').cmp_action()

	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<C-y>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-f>'] = cmp_action.luasnip_jump_forward(),
			['<C-b>'] = cmp_action.luasnip_jump_backward(),
		})
	})
end

local lsp_zero_config = function()
	local lsp_zero = require('lsp-zero')
	local lsp_config = require('lspconfig')
	local on_attach = function(client, bufnr)
		-- see :help lsp-zero-keybindings
		-- to learn the available actions
		lsp_zero.default_keymaps({buffer = bufnr})

		local opts = { buffer = bufnr, remap = false }

		vim.keymap.set('n', '<leader>actions', function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, opts)
		vim.keymap.set('n', '<leader>rename', function() vim.lsp.buf.rename() end, opts)
	end
	lsp_zero.extend_lspconfig()
	lsp_config['dartls'].setup({
		on_attach = on_attach,
	})
	lsp_zero.on_attach = on_attach
end

return {
	-- lsp servers
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup({})
		end,
		lazy = false
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			local lsp_zero = require('lsp-zero')
			require ('mason-lspconfig').setup({
				handlers = {
					lsp_zero.default_setup
				},
				ensure_installed = {
					'rust_analyzer',
					'tsserver'
				}
			})
		end,
		lazy = false
	},
	-- lsp support
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = lsp_zero_config
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'hrsh7th/cmp-nvim-lsp'
			},
		}
	},
	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		config = cmp_config,
		dependencies = {
			{
				'L3MON4D3/LuaSnip'
			}
		}
	}
}

