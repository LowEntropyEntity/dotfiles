local opt = vim.opt

-- tab / indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.wrap = false

-- search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = '100'
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 8
opt.completeopt = "menuone,noinsert,noselect"

-- whitespace
opt.list = true
opt.listchars:append("tab:➝ ")
opt.listchars:append("multispace:·")
opt.listchars:append("nbsp:␣")
opt.listchars:append("eol:¬")
opt.listchars:append("precedes:«")
opt.listchars:append("extends:»")
opt.listchars:append("lead:·")
opt.listchars:append("trail:•")

-- behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append('a')
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
opt.encoding = "UTF-8"

vim.api.nvim_create_autocmd("TextYankPost", {
	group = general_settings,
	desc = "highlight yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end
})

