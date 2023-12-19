vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

-- pane navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'panes: navigate left' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'panes: navigate down' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'panes: navigate up' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'panes: navigate right' })

-- window management
keymap.set('n', '<leader>h', ':set nosplitright<cr>:vnew<cr>:set splitright<cr>', { desc = 'panes: split left' })
keymap.set('n', '<leader>k', ':set nosplitbelow<cr>:new<cr>:set splitbelow<cr>', { desc = 'panes: split up' })
keymap.set('n', '<leader>l', ':vnew<cr>', { desc = 'panes: split right' })
keymap.set('n', '<leader>j', ':new<cr>', { desc = 'panes: split down' })
keymap.set('n', '<leader>yh', ':set nosplitright<cr>:vsplit<cr>:set splitright<cr>', { desc = 'panes: clone left' })
keymap.set('n', '<leader>yk', ':set nosplitbelow<cr>:split<cr>:set splitbelow<cr>', { desc = 'panes: clone up' })
keymap.set('n', '<leader>yl', ':vsplit<cr>', { desc = 'panes: clone right' })
keymap.set('n', '<leader>yj', ':split<cr>', { desc = 'panes: clone down' })

keymap.set('n', '<leader>ws', ':set nolist!<cr>', { desc = 'toggle whitespace' })

keymap.set('n', '<leader>ww', ':set linebreak! wrap!<cr>', { desc = 'toggle word wrap' })

keymap.set('n', '<leader>ln', ':set nornu!<cr>', { desc = 'toggle relative / absolute line numbers' })

local function spaces_to_tabs()
	local original = vim.o.tabstop
	local count = (vim.v.count ~= 0) and vim.v.count or original

	vim.o.tabstop = count

	vim.cmd('%retab!')

	vim.o.tabstop = original
end
keymap.set('n', '<leader>stt', spaces_to_tabs, { desc = 'convert spaces to tabs' })

local function tabs_to_spaces()
	local original_tabstop = vim.o.tabstop
	local original_shiftwidth = vim.o.shiftwidth
	local original_expandtab = vim.o.expandtab
	local count = (vim.v.count ~= 0) and vim.v.count or original_shiftwidth

	vim.o.tabstop = count
	vim.o.shiftwidth = count
	vim.o.expandtab = true

	vim.cmd('%retab!')

	vim.o.tabstop = original_tabstop
	vim.o.shiftwidth = original_shiftwidth
	vim.o.expandtab = original_expandtab
end
keymap.set('n', '<leader>tts', tabs_to_spaces, { desc = 'convert tabs to spaces' })

keymap.set('n', '<leader>hs', ':set nohlsearch!<cr>', { desc = 'toggle highlight search' })
keymap.set('n', '<esc>', ':nohlsearch<cr>', { desc = 'unhighlight search' })

-- transparency
keymap.set('n', '<leader>tp', function()
	local catppuccin = require('catppuccin')
	catppuccin.options.transparent_background = not catppuccin.options.transparent_background
	catppuccin.compile()
	vim.cmd.colorscheme(vim.g.colors_name)
end, { desc = 'toggle transparency' })

vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false, desc = 'toggle comments' })
vim.api.nvim_set_keymap('v', '<C-_>', 'gcc', { noremap = false, desc = 'toggle comments' })

keymap.set('v', '<', '<gv', { desc = 'indent less' })
keymap.set('v', '>', '>gv', { desc = 'indent more' })

-- move lines in visual mode
keymap.set('v', 'J', ":m '>+1<cr>gv=gv", { desc = 'move line up' })
keymap.set('v', 'K', ":m '<-2<cr>gv=gv", { desc = 'move line down' })

-- paging
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'page down' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'page up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'next search match' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'previous search match' })

keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste without saving overwritten text in the paste buffer' })

keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = 'sed current selection' })

