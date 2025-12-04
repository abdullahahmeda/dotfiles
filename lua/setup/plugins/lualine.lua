require('lualine').setup({
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
  sections = {
    lualine_a = {
      {
        'mode',
        color = { gui = 'bold', bg = 'None', fg = 'None' }
      }
    },
    lualine_b = {
      {
        'branch',
        padding = 4
      },
    },
    lualine_c = {'filename',
    { 
      'lsp_status',
      padding = 4,
      icon = '',
      symbols = {
        done = ''
      }
  },
      'diagnostics'
  },
    lualine_x = {'diff',  'filetype'},
    lualine_z = {'location'}
  }
})


