local filetype = { "filetype", icon_only = true }

require('lualine').setup {
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_c = { "filename", },
    lualine_x = { 'diff', 'diagnostics', filetype },
    lualine_y = {},
    lualine_z = {},
  }
}
