vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

-- directory navigation
keymap.set('n', '<leader>m', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- pane navigation
keymap.set('n', '<C-h>', '<C-w>h', opts) -- navigate left
keymap.set('n', '<C-j>', '<C-w>j', opts) -- navigate down
keymap.set('n', '<C-k>', '<C-w>k', opts) -- navigate up
keymap.set('n', '<C-l>', '<C-w>l', opts) -- navigate right

-- window management
keymap.set('n', '<leader>sv', ':vsplit<CR>', opts) -- split vertically
keymap.set('n', '<leader>sh', ':split<CR>', opts) -- split horizontally

-- whitespace
keymap.set('n', '<leader>ws', ':set nolist!<CR>', opts)
keymap.set('n', '<leader>ln', ':set nornu!<CR>', opts)

-- transparency
keymap.set('n', '<leader>t', function()
	local catppuccin = require('catppuccin')
	catppuccin.options.transparent_background = not catppuccin.options.transparent_background
	catppuccin.compile()
	vim.cmd.colorscheme(vim.g.colors_name)
end)

-- toggle comments
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = false })
vim.api.nvim_set_keymap('v', '<C-_>', 'gcc', { noremap = false })

-- indentation
keymap.set('v', '<', "<gv")
keymap.set('v', '>', ">gv")

-- telescope
keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>')
keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')

-- undo tree
keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

-- git (fugitive)
keymap.set('n', '<leader>gs', ':Git<CR>')

-- move lines in visual mode
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- paging
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')

-- paste without saving overwritten text in the paste buffer
keymap.set('x', '<leader>p', '\"_dP')

-- sed current selection
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

