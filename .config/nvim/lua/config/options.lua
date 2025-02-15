local opt = vim.opt

-- tab / indentation
opt.tabstop = 3
opt.shiftwidth = 3
opt.expandtab = false -- don't auto convert tabs to spaces
opt.smartindent = true

-- word wrap
opt.wrap = false
opt.breakindent = true -- wrapped lines keep indentation
opt.breakindentopt = 'shift:3,list:-1,sbr'

-- search
opt.incsearch = true -- highlight as you type a search string
opt.ignorecase = true
opt.smartcase = true -- searches are case insensitive iff the search string is all lowercase
opt.hlsearch = true

-- appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = '100'
opt.signcolumn = 'yes'
opt.cmdheight = 1
opt.scrolloff = 8
opt.completeopt = 'menuone,noinsert,noselect'
opt.showmode = false

-- whitespace
opt.list = true
opt.listchars:append('tab:➝ ')
opt.listchars:append('multispace:·')
opt.listchars:append('nbsp:␣')
opt.listchars:append('eol:¬')
opt.listchars:append('precedes:«')
opt.listchars:append('extends:»')
opt.listchars:append('lead:·')
opt.listchars:append('trail:•')
opt.showbreak = '↪ '

-- behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand('~/.vim/undodir')
opt.undofile = true
opt.backspace = 'indent,eol,start'
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append('-')
opt.mouse:append('a')
opt.clipboard:append('unnamedplus')
opt.modifiable = true
opt.guicursor = 'n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
opt.encoding = 'UTF-8'

-- rust
vim.g.rust_recommended_style = false

vim.diagnostic.config({
	float = { border = 'rounded', },
})
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
