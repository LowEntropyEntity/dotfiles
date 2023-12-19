local config = function()
	local avante = require('avante')
	avante.setup({
		---@alias Provider 'claude' | 'openai' | 'azure' | 'gemini' | 'cohere' | 'copilot' | string
		provider = 'claude', -- recommend using Claude
		-- WARNING: auto-suggestions are a high-frequency operation and therefore expensive,
		-- designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
		-- you can reduce the request frequency by increasing `suggestion.debounce`.
		auto_suggestions_provider = 'claude',
		claude = {
			endpoint = 'https://api.anthropic.com',
			model = 'claude-3-5-sonnet-20241022',
			temperature = 0,
			max_tokens = 4096,
		},
		--- WARNING: experimental feature
		dual_boost = {
			enabled = false,
			first_provider = 'openai',
			second_provider = 'claude',
			--- prompt: prompt to merge outputs
			prompt = 'Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]',
			timeout = 60000, -- ms
		},
		behaviour = {
			auto_suggestions = false, -- experimental
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- remove unchanged lines when applying a code block
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = 'co',
				theirs = 'ct',
				all_theirs = 'ca',
				both = 'cb',
				cursor = 'cc',
				next = ']x',
				prev = '[x',
			},
			suggestion = {
				accept = '<M-l>',
				next = '<M-]>',
				prev = '<M-[>',
				dismiss = '<C-]>',
			},
			jump = {
				next = ']]',
				prev = '[[',
			},
			submit = {
				normal = '<cr>',
				insert = '<C-s>',
			},
			sidebar = {
				apply_all = 'A',
				apply_cursor = 'a',
				switch_windows = '<Tab>',
				reverse_switch_windows = '<S-Tab>',
			},
		},
		hints = { enabled = true },
		windows = {
			---@type 'right' | 'left' | 'top' | 'bottom'
			position = 'right', -- sidebar
			wrap = true, -- similar to vim.o.wrap
			width = 30, -- default % based on available width
			sidebar_header = {
				enabled = true,
				align = 'center', -- title
				rounded = true,
			},
			input = {
				prefix = '> ',
				height = 8,
			},
			edit = {
				border = 'rounded',
				start_insert = true, -- start in insert mode
			},
			ask = {
				floating = false, -- floating window
				start_insert = true, -- start in insert mode
				border = 'rounded',
				---@type 'ours' | 'theirs'
				focus_on_apply = 'ours', -- which diff to focus after applying
			},
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = 'DiffText',
				incoming = 'DiffAdd',
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): any
			list_opener = 'copen',
			--- override 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
			--- helps to avoid entering operator-pending mode with diff mappings starting with `c`.
			--- disable by setting to -1.
			override_timeoutlen = 500,
		},
		suggestion = {
			debounce = 600,
			throttle = 600,
		},
	})
end

return {
	'yetone/avante.nvim',
	config = config,
	enabled = false,
	opts = {
		-- add any opts here
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = 'make',
	dependencies = {
		'stevearc/dressing.nvim',
		'nvim-lua/plenary.nvim',
		'MunifTanjim/nui.nvim',

		--- optional ---
		'echasnovski/mini.pick', -- for file_selector
		'nvim-telescope/telescope.nvim', -- for file_selector
		'hrsh7th/nvim-cmp', -- autocomplete for avante commands and mentions
		'ibhagwan/fzf-lua', -- for file_selector
		'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
		'zbirenbaum/copilot.lua', -- for providers='copilot'
		{
			-- support for image pasting
			'HakonHarnes/img-clip.nvim',
			event = 'VeryLazy',
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
		{
			-- make sure to set this up properly if `lazy=true`
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { 'markdown', 'Avante' },
			},
			ft = { 'markdown', 'Avante' },
		},
	},
}
