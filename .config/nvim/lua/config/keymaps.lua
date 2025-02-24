vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

-- window navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'windows: navigate left' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'windows: navigate down' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'windows: navigate up' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'windows: navigate right' })

-- window movement
keymap.set('n', '◂', function() require('utils.windows').swap_buffer('h') end, { desc = 'windows: move left', noremap = true })
keymap.set('n', '▾', function() require('utils.windows').swap_buffer('j') end, { desc = 'windows: move down', noremap = true })
keymap.set('n', '▴', function() require('utils.windows').swap_buffer('k') end, { desc = 'windows: move up', noremap = true })
keymap.set('n', '▸', function() require('utils.windows').swap_buffer('l') end, { desc = 'windows: move right', noremap = true })

-- window management
keymap.set('n', '<leader>h', ':set nosplitright<cr>:vnew<cr>:set splitright<cr>', { desc = 'windows: split left' })
keymap.set('n', '<leader>k', ':set nosplitbelow<cr>:new<cr>:set splitbelow<cr>', { desc = 'windows: split up' })
keymap.set('n', '<leader>l', ':vnew<cr>', { desc = 'windows: split right' })
keymap.set('n', '<leader>j', ':new<cr>', { desc = 'windows: split down' })
keymap.set('n', '<leader>yh', ':set nosplitright<cr>:vsplit<cr>:set splitright<cr>', { desc = 'windows: clone left' })
keymap.set('n', '<leader>yk', ':set nosplitbelow<cr>:split<cr>:set splitbelow<cr>', { desc = 'windows: clone up' })
keymap.set('n', '<leader>yl', ':vsplit<cr>', { desc = 'windows: clone right' })
keymap.set('n', '<leader>yj', ':split<cr>', { desc = 'windows: clone down' })
-- resize windows - ctrl + arrow
keymap.set('n', '<leader>K', ':resize +2<cr>', { desc = 'windows: increase height' })
keymap.set('n', '<leader>J', ':resize -2<cr>', { desc = 'windows: decrease height' })
keymap.set('n', '<leader>L', ':vertical resize -2<cr>', { desc = 'windows: increase width' })
keymap.set('n', '<leader>H', ':vertical resize +2<cr>', { desc = 'windows: decrease width' })

keymap.set('n', '<leader>uiws', ':set nolist!<cr>', { desc = 'toggle whitespace' })

keymap.set('n', '<leader>uiww', ':set linebreak! wrap!<cr>', { desc = 'toggle word wrap' })

keymap.set('n', '<leader>uiln', ':set nornu!<cr>', { desc = 'toggle relative / absolute line numbers' })

keymap.set({'n', 'x'}, '<leader>crstt', function() require('utils.indentation').spaces_to_tabs() end, { desc = 'convert spaces to tabs' })
keymap.set({'n', 'x'}, '<leader>crtts', function() require('utils.indentation').tabs_to_spaces() end, { desc = 'convert tabs to spaces' })

keymap.set('n', '<leader>hs', ':set nohlsearch!<cr>', { desc = 'toggle highlight search' })
keymap.set('n', '<esc>', ':nohlsearch<cr>', { desc = 'unhighlight search', silent = true })

-- transparency
keymap.set('n', '<leader>uit', function()
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
keymap.set('n', 'n', 'nzzzv', { desc = 'next search match' })
keymap.set('n', 'N', 'Nzzzv', { desc = 'previous search match' })

keymap.set('x', '<leader>p', [["_dP]], { desc = 'paste without saving overwritten text in the paste buffer' })

keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { desc = 'sed current selection' })
