require("conform").setup({
  formatters_by_ft = {
    javascript = {'prettierd'},
    javascriptreact = {'prettierd'},
    typescriptreact = {'prettierd'},
    typescript = {'prettierd'},
    html = {'prettierd'},
    php = {'pint'},
    python = { 'ruff_format' },
    dart = { 'dart_format' }
  },
})

