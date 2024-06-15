require("vim_options")

-- Bootstrap package manager (Lazy)
require('bootstrap')

require("lazy").setup({
  {
    'neoclide/coc.nvim',
    branch = 'release'
  },

  {
    "nivm-lua/plenary.nvim"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- Auto session (for restoring previous sessions)
  {
    'rmagatti/auto-session',
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/projects", "/var/www", "~/.config" },
    }
  },

  -- Icons
  {
    'nvim-tree/nvim-web-devicons',
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  -- Detect indentation
  {
    "tpope/vim-sleuth"
  },

  -- Colorscheme
  {
    "EdenEast/nightfox.nvim"
  },

  -- Statuscolumn
  { "luukvbaal/statuscol.nvim" },

  -- Fold
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async'
  },

  {
    'kevinhwang91/nvim-bqf',
    opts = {
      func_map = {
        open = '<CR>',
        openc = 'o',
        drop = '',
        split = '<C-x>',
        vsplit = '<C-v>',
        tab = '',
        tabb = '',
        tabc = '',
        tabdrop = '',
        ptogglemode = 'zp',
        ptoggleitem = 'p',
        ptoggleauto = 'P',
        pscrollup = '<C-u>',
        pscrolldown = '<C-d>',
        pscrollorig = 'zo',
        prevfile = '', -- Already handled in another place. See setup_mappings()
        nextfile = '',
        prevhist = '<',
        nexthist = '>',
        lastleave = '',
        stoggleup = '<S-Tab>',
        stoggledown = '<Tab>',
        stogglevm = '<Tab>',
        stogglebuf = '',
        sclear = 'z<Tab>',
        filter = 'zn',
        filterr = 'zN',
        fzffilter = ''
      }
    }
  },

  {
    "aserowy/tmux.nvim",
    opts = {}
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  { 'prisma/vim-prisma' },

  -- Automatic documentaion generator
  { 'kkoomen/vim-doge',        build = ':call doge#install()' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {}
  },

  { 'tpope/vim-fugitive' }

})


vim.cmd("colorscheme nightfox")


function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

local setup_mappings = function()
  -- Coc.nvim
  vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]],
    { desc = "Select current item for autocompletion", silent = true, expr = true, noremap = true, replace_keycodes = false })
  vim.keymap.set("i", "<C-space>", "coc#refresh()", { desc = "Trigger compltion", silent = true, expr = true })
  vim.keymap.set("n", "]e", "<Plug>(coc-diagnostic-next)", { desc = "Go to next diagnostic", silent = true })
  vim.keymap.set("n", "[e", "<Plug>(coc-diagnostic-prev)", { desc = "Go to prev diagnostic", silent = true })
  vim.keymap.set('n', 'gd', "<Plug>(coc-definition)", { desc = "Go to definition", silent = true })
  vim.keymap.set('n', 'gr', "<Plug>(coc-references)", { desc = "List symbol references", silent = true })
  vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })
  vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
  vim.keymap.set('n', '<leader>xx', ":<C-u>CocList diagnostics<cr>",
    { desc = "Buffer diagnostics", silent = true, nowait = false })
  vim.keymap.set("n", "<leader>ds", ":<C-u>CocList outline<cr>",
    { desc = "List document symbols", silent = true, nowait = false })

  -- Ultra UFO. Prefixed with: z
  vim.keymap.set('n', 'zE', require('ufo').openAllFolds, { desc = "Expand all folds" })
  vim.keymap.set('n', 'zC', require('ufo').closeAllFolds, { desc = "Collapse all folds" })

  -- Quickfix
  vim.keymap.set('n', '[q', '<Cmd>cprev<CR>', { desc = "Previous qfixlist item" })
  vim.keymap.set('n', ']q', '<Cmd>cnext<CR>', { desc = "Previous qfixlist item" })

  -- Telescope. Prefixed with: <leader>f
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
  vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Find string under cursor" })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
  vim.keymap.set('n', '<leader>fe', require("telescope").extensions.file_browser.file_browser, { desc = 'File explorer' })
end

setup_mappings()

local setup_treesitter = function()
  require 'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
    },
  }
end

setup_treesitter()

local setup_highlight_on_yank = function()
  local augroup = vim.api.nvim_create_augroup("HighlightOnYank", {})
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.api.nvim_clear_autocmds({ group = augroup })
      vim.highlight.on_yank()
    end
  })
end

setup_highlight_on_yank()

local setup_folding = function()
  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end
  })
end

setup_folding()

local setup_statuscolumn = function()
  local builtin = require("statuscol.builtin")
  require("statuscol").setup({
    relculright = true,
    segments = {
      -- Sign
      { text = { " ", "%s" },             click = "v:lua.ScSa" },
      -- Line number
      { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa", },
      -- Fold
      {
        text = { builtin.foldfunc, " " },
        click = "v:lua.ScFa"
      },
    }
  })
end

setup_statuscolumn()


local setup_telescope = function()
  local actions = require('telescope.actions')
  local fb_actions = require('telescope').extensions.file_browser.actions
  require('telescope').setup {
    defaults = {
      initial_mode = "normal",
      -- sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
        height = 0.5,
        width = 0.6
      },
      theme = 'dropdown',
      preview = {
        hide_on_startup = true
      },
      mappings = {
        ['n'] = {
          ["q"] = actions.close,
          ['P'] = require('telescope.actions.layout').toggle_preview
        }
      },
    },
    pickers = {
      find_files = {
        initial_mode = "insert",
      },
      live_grep = {
        initial_mode = "insert",
      },
      buffers = {
        mappings = {
          ["n"] = {
            ["dd"] = actions.delete_buffer,
          }
        }
      }
    },
    extensions = {
      file_browser = {
        hijack_netrw = true,
        path = '%:p:h',
        hidden = { file_browser = true, folder_browser = true },
        grouped = true,
        mappings = {
          ['n'] = {
            ['d'] = false,
            ['r'] = false,
            ['m'] = false,
            ['y'] = false,
            ['h'] = false,
            ['e'] = false,
            ['g'] = false,
            ['u'] = fb_actions.goto_parent_dir,
            ['dd'] = fb_actions.remove,
            ['rn'] = fb_actions.rename,
            ['mm'] = fb_actions.move,
            ['yy'] = fb_actions.copy,
            ['H'] = fb_actions.toggle_hidden,
          }
        }
      }
    }
  }

  require("telescope").load_extension "file_browser"
end

setup_telescope()

local setup_commands = function()
  vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
end

setup_commands()
