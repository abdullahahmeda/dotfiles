require 'vim_options'

-- Bootstrap package manager (Lazy)
require 'bootstrap'


require('lazy').setup {
  {
    { 'williamboman/mason.nvim', opts = {} },
    { 'williamboman/mason-lspconfig.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },

  { 'nvimtools/none-ls.nvim' },
  { 'nvimtools/none-ls-extras.nvim' },

  -- { 'hrsh7th/cmp-nvim-lsp' },
  -- { 'hrsh7th/nvim-cmp' },

  {
    'saghen/blink.cmp',
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = {
        enabled = false,
      },

      keymap = { preset = 'default' },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'snippets' },
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },

  { 'nvim-lua/plenary.nvim' },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require 'lspconfig'
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
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

function custom_format()
  vim.lsp.buf.format { range = nil }
end

vim.api.nvim_create_user_command('Format', custom_format, {})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 200 }
  end,
})

require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        [']f'] = '@function.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
      },
    },
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
      },
    },
  },
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

local bufdelete = require 'plugins/bufdelete'
vim.keymap.set('n', '<leader>bd', bufdelete.delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bo', bufdelete.other, { desc = 'Keep the current buffer only', silent = true })
