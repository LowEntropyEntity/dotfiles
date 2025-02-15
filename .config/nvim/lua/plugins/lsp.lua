local lsp_config = function()
	local lsp_defaults = require('lspconfig').util.default_config

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require('blink.cmp').get_lsp_capabilities()
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

			vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts('hover'))
			vim.keymap.set('n', '<leader>c?', function() vim.lsp.buf.hover() end, opts('hover'))
			vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts('signature'))
			vim.keymap.set('n', '<leader>cgs', function() vim.lsp.buf.signature_help() end, opts('signature'))
			vim.keymap.set('n', '<F12>', function() vim.lsp.buf.definition() end, opts('go to definition'))
			vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts('go to definition'))
			vim.keymap.set('n', '<leader>cgd', function() vim.lsp.buf.definition() end, opts('go to definition'))
			vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts('go to declaration'))
			vim.keymap.set('n', '<leader>cgD', function() vim.lsp.buf.declaration() end, opts('go to declaration'))
			vim.keymap.set('n', '<F36>', function() telescope.lsp_implementations() end, opts('find all implementations')) -- ctrl + F12
			vim.keymap.set('n', 'gi', function() telescope.lsp_implementations() end, opts('find all implementations'))
			vim.keymap.set('n', '<leader>cfi', function() telescope.lsp_implementations() end, opts('find all implementations'))
			vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts('go to type definition'))
			vim.keymap.set('n', '<leader>cgo', function() vim.lsp.buf.type_definition() end, opts('go to type definition'))
			vim.keymap.set('n', '<F24>', function() telescope.lsp_references() end, opts('find all references')) -- shift + F12
			vim.keymap.set('n', 'gr', function() telescope.lsp_references() end, opts('find all references'))
			vim.keymap.set('n', '<leader>cfr', function() telescope.lsp_references() end, opts('find all references'))
			vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts('rename symbol'))
			vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts('format document'))
			vim.keymap.set('n', '<leader>crf', function() vim.lsp.buf.format() end, opts('format'))
			vim.keymap.set('n', '<leader>cra', function() vim.lsp.buf.code_action() end, opts('actions'))
			vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts('rename symbol'))
			vim.keymap.set('n', '<leader>crr', function() vim.lsp.buf.rename() end, opts('rename symbol'))
		end,
	})
	require('mason').setup()
	require('mason-lspconfig').setup({
		ensure_installed = {},
		automatic_installation = true,
		handlers = {
			-- this first function is the "default handler"
			-- it applies to every language server without a "custom handler"
			function(server_name)
				require('lspconfig')[server_name].setup({})
			end,
		}
	})

	local mason_registry = require('mason-registry')

	local packages = {
		'tree-sitter-cli',
	}

	mason_registry.refresh()
	for _, pkg_name in pairs(packages) do
		local package = mason_registry.get_package(pkg_name)
		if not package:is_installed() then
			vim.notify("installing " .. pkg_name, vim.log.levels.INFO)
			package:install()
		end
	end
end

local get_language_servers = function()
	local language_servers = {}
	local languages = require('config.languages')
	for _, language in ipairs(languages) do
		for _, server in ipairs(language.servers or {}) do
			table.insert(language_servers, server)
		end
	end
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
			servers = get_language_servers()
		},
		cmd = {'LspInfo', 'LspInstall', 'LspStart' },
		event = {'BufReadPre', 'BufNewFile'},
		config = lsp_config,
		dependencies = {
			{
				{'saghen/blink.cmp'},
				{'williamboman/mason.nvim'},
				{'williamboman/mason-lspconfig.nvim'},
			},
		},
		init = function()
			-- reserve a space in the gutter
			-- this will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = 'yes'
		end,
	}
}
