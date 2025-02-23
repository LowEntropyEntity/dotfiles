return {
	'saghen/blink.cmp',
	event = "InsertEnter",
	-- optional: provides snippets for the snippet source
	dependencies = 'rafamadriz/friendly-snippets',

	opts = {
		keymap = {
			preset = 'none',

			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			['<C-e>'] = { 'hide' },
			['<Tab>'] = {
				function(cmp)
					if cmp.snippet_active() then return cmp.accept()
					else return cmp.accept() end
				end,
				'snippet_forward',
				'fallback'
			},
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },

			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },

			['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-l>'] = { 'select_and_accept' },

			['<C-h>'] = { 'show_signature', 'hide_signature' },
		},

		appearance = {
			nerd_font_variant = 'mono'
		},

		completion = {
			documentation = {
				window = {
					border = 'rounded'
				}
			},
			ghost_text = {
				enabled = true,
				show_with_selection = true,
				show_without_selection = false,
			},
			list = {
				selection = {
					preselect = false, auto_insert = false
				}
			},
			menu = {
				border = 'rounded'
			}
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
	},
	opts_extend = { "sources.default" }
}
