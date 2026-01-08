require("conform").setup({
  formatters_by_ft = {
    javascript = {'prettierd'},
    javascriptreact = {'prettierd'},
    typescriptreact = {'prettierd'},
    typescript = {'prettierd'},
    html = {'prettierd'},
    -- php = {'php-cs-fixer'},
    python = { 'ruff_format' }
  },
  -- formatters = {
  --     ["php-cs-fixer"] = {
  --       command = "php-cs-fixer",
  --       args = {
  --         "fix",
  --         "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
  --         "$FILENAME",
  --       },
  --       stdin = false,
  --     },
  --   },
})

