require 'vim_options'

-- Bootstrap package manager (Lazy)
require 'bootstrap'

require('lazy').setup {
  {
    { 'williamboman/mason.nvim',           opts = {} },
    { 'williamboman/mason-lspconfig.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },

  { 'nvimtools/none-ls.nvim' },
  { 'nvimtools/none-ls-extras.nvim' },

  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },

  { 'nivm-lua/plenary.nvim' },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },

  -- Auto session (for restoring previous sessions)
  {
    'rmagatti/auto-session',
    opts = {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/projects', '/var/www', '~/.config' },
    },
  },

  -- Icons
  { 'nvim-tree/nvim-web-devicons', opts = {} },

  -- Detect indentation
  { 'tpope/vim-sleuth' },

  -- Colorscheme
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'original'
    end,
  },

  -- Fold
  -- {
  --   'kevinhwang91/nvim-ufo',
  --   dependencies = 'kevinhwang91/promise-async'
  -- },

  -- {
  --   "aserowy/tmux.nvim",
  --   opts = {}
  -- },

  -- {
  --   'nvim-telescope/telescope.nvim',
  --   tag = '0.1.8',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  -- },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
    opts = {
      skip_confirm_for_simple_edits = true,
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  { 'tpope/vim-surround' },
}

vim.cmd.colorscheme 'gruvbox-material'

require('mason-lspconfig').setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end
}

local cmp = require 'cmp'

cmp.setup {
  completion = { autocomplete = false },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  }),
  mapping = cmp.mapping.preset.insert {
    -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },

  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- formatting = {
  --   format = function(entry, vim_item)
  --     if vim.tbl_contains({ 'path' }, entry.source.name) then
  --       local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
  --       if icon then
  --         vim_item.kind = icon
  --         vim_item.kind_hl_group = hl_group
  --         return vim_item
  --       end
  --     end
  --     return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
  --   end
  -- }
}

function custom_format()
  vim.lsp.buf.format { range = nil }
end

vim.api.nvim_create_user_command('Format', custom_format, {})

-- local setup_mappings = function()
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition", silent = true })
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
--   -- vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_document_symbols, { noremap = true, silent = true })
--
--   vim.keymap.set('n', '<C-h>', '<Cmd>noh<Cr>')
--
--   -- Quickfix
--   vim.keymap.set('n', '[q', '<Cmd>cprev<CR>', { desc = "Previous qfixlist item" })
--   vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { desc = "Previous qfixlist item" })
--
--   -- Telescope. Prefixed with: <leader>f
--   local builtin = require('telescope.builtin')
--   vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
--   vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Find string under cursor" })
--   vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
--   vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
--   vim.keymap.set('n', '<leader>fe', '<Cmd>Oil --float<Cr>', { desc = 'File explorer' })
--
--   vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--   vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- end

-- setup_mappings()

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 200 }
  end,
})

require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
}

local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    require('none-ls.diagnostics.eslint_d').with {
      diagnostics_format = '[eslint] #{m}\n(#{c})',
    },
  },
}

vim.keymap.set('n', '<leader>oo', ':Oil<CR>', { desc = 'Open file explorer' })

vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, { desc = 'Implementation' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'Definition' })

vim.keymap.set('n', '<leader>tt', function()
  vim.cmd.new()
  vim.cmd.wincmd 'J'
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 8)
end, { desc = 'Open terminal' })

local bufdelete = require('plugins/bufdelete')
vim.keymap.set('n', '<leader>bd', bufdelete.delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bo', bufdelete.other, { desc = 'Keep the current buffer only', silent = true })
