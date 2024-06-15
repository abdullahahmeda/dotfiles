vim.g.mapleader      = " "

vim.opt.shiftwidth   = 2
vim.opt.tabstop      = 2
vim.o.expandtab      = true

vim.o.number         = true
vim.o.relativenumber = true
vim.o.cursorline     = true

vim.opt.clipboard    = "unnamedplus"

vim.o.ignorecase     = true
vim.o.smartcase      = true

-- For ultra-ufo
vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.o.foldenable     = true
vim.o.fillchars      = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Fixes a bug for auto-session when there are folds
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.grepprg      = "rg --vimgrep"
vim.opt.grepformat   = "%f:%l:%c:%m"


-- Some servers have issues with backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"


-- Vim doge
vim.g.doge_mapping = '<leader>gd'
