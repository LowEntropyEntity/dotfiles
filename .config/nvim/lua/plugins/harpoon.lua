local config = function()
	local harpoon = require('harpoon')
	harpoon:setup({})

	local conf = require('telescope.config').values
	local toggle_telescope = function(harpoon_files)
		local file_paths = {}
		for _, item in ipairs(harpoon_files.items) do
			table.insert(file_paths, item.value)
		end

		require('telescope.pickers').new({}, {
			prompt_title = 'Harpoon',
			finder = require('telescope.finders').new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		}):find()
	end

	vim.keymap.set('n', '<C-e>', function() toggle_telescope(harpoon:list()) end, { desc = 'harpoon: open' })
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	config = config,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope.nvim',
	}
}
