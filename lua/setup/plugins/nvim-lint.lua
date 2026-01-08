local lint = require 'lint'
lint.linters_by_ft = {
  javascript = {'eslint_d'},
  javascriptreact = {'eslint_d'},
  typescriptreact = {'eslint_d'},
  typescript = {'eslint_d'},
  python = { 'ruff' },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

