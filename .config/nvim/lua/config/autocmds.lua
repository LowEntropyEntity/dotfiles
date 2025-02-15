-- copied from https://www.lazyvim.org/

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
	callback = function()
		if vim.o.buftype ~= 'nofile' then
			vim.cmd('checktime')
		end
	end,
})

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		(vim.hl or vim.highlight).on_yank({ timeout = 500 })
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd('tabdo wincmd =')
		vim.cmd('tabnext ' .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function(event)
		local exclude = { 'gitcommit' }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with 'q'
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'PlenaryTestPopup',
		'checkhealth',
		'dbout',
		'gitsigns-blame',
		'grug-far',
		'help',
		'lspinfo',
		'neotest-output',
		'neotest-output-panel',
		'neotest-summary',
		'notify',
		'qf',
		'spectre_panel',
		'startuptime',
		'tsplayground',
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set('n', 'q', function()
				vim.cmd('close')
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = 'quit buffer',
			})
		end)
	end,
})

-- spell check in some filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = { 'json', 'jsonc', 'json5' },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- auto create dir when saving a file
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	callback = function(event)
		if event.match:match('^%w%w+:[\\/][\\/]') then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
	end,
})

local languages = require('config.languages')

---@param config LanguageConfig
local function install_mason_tools(config)
	local mason_registry = require('mason-registry')
	mason_registry.refresh()
	if config.mason and config.mason.tools then
		for _, tool in ipairs(config.mason.tools) do
			if not mason_registry.is_installed(tool) then
				vim.notify('Installing ' .. tool, vim.log.levels.INFO)
				vim.cmd('MasonInstall ' .. tool)
			end
		end
	end

	if config.dap then
		if config.dap.config then
			if config.dap.config.mason and config.dap.config.mason.tools then
				for _, tool in ipairs(config.dap.config.mason.tools) do
					if not mason_registry.is_installed(tool) then
						vim.notify('Installing dap ' .. tool, vim.log.levels.INFO)
						vim.cmd('MasonInstall ' .. tool)
					end
				end
			end

			if config.dap.config.adapters then
				local dap = require('dap')
					for name, adapter in pairs(config.dap.config.adapters) do
						if not dap.adapters[name] then
							dap.adapters[name] = adapter
						end
					end
				for _, language in ipairs(config.dap.config.languages) do
					if not dap.configurations[language] then
						dap.configurations[language] = config.dap.config.configurations
					end
				end
			end
		end
	end
end

-- install mason tools for directory
local function install_mason_tools_for_dir()
	local cwd = vim.loop.cwd()

	for _, config in pairs(languages) do
		local root_files = config.root_files
		if root_files then
			for _, filename in ipairs(root_files) do
				local path = cwd .. "/" .. filename
				local f = io.open(path, "r")

				if f ~= nil then
					f:close()

					install_mason_tools(config)
					-- we've already matched root_files and installed tools
					break
				end
			end
		end
	end
end

-- install mason tools for file type
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = {
		'go',
		'lua',
		'typescript',
	},
	callback = function()
		local lang_config = languages[vim.bo.filetype]
		if lang_config then
			install_mason_tools(lang_config)
		end

	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		install_mason_tools_for_dir()
	end,
})

vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		install_mason_tools_for_dir()
	end,
})
