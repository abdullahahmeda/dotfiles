-- NOTE: this exact configuration depends on: https://github.com/nvim-treesitter/nvim-treesitter-textobjects 
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  -- textobjects = {
  --   move = {
  --     enable = true,
  --     goto_next_start = {
  --       [']f'] = '@function.outer',
  --     },
  --     goto_previous_start = {
  --       ['[f'] = '@function.outer',
  --     },
  --   },
  --   select = {
  --     enable = true,
  --     keymaps = {
  --       ['af'] = '@function.outer',
  --       ['if'] = '@function.inner',
  --     },
  --   },
  -- },
}


