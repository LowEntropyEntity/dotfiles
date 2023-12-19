local config = function()
	require('nvim-tree').setup({
		filters = {
			dotfiles = false,
		}
	})
	-- directory navigation
	vim.keymap.set('n', '<leader>m', ':NvimTreeFocus<cr>', { noremap = true, silent = true, desc = 'nvim-tree: focus on tree' })
	vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<cr>', { noremap = true, silent = true, desc = 'nvim-tree: open/close tree' })

end

return {
	'nvim-tree/nvim-tree.lua',
	lazy = false,
	config = config
}

