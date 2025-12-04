require('blink.cmp').setup {
  keymap = { 
    ['<C-k>'] = { 'show_documentation', 'hide_documentation' },
    ['<C-n>'] = { 'select_next', 'show' },
    ['<C-p>'] = { 'select_prev', 'show' },
    ['<C-y>'] = { 'select_and_accept' },
    -- ['<Tab>'] = { 'snippet_forward' },
    -- ['<S-Tab>'] = { 'snippet_backward' },
  },

  fuzzy = { implementation = 'lua' },
  cmdline = { enabled = false },

  completion = {
    menu = {
      auto_show = false,
      draw = {
      columns = {
        { "kind_icon", "label",  gap = 1 },
        { "kind", "label_description", gap = 2 }
      },
      }
    },
  }
}
