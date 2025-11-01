-- jump-to-word support
return {
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      keys = 'etovxqpdygfblzhckisuran',
    },
    config = function()
      require('hop').setup()
      vim.keymap.set('n', 'gw', ':HopWord<cr>', { desc = 'Hop to word' })
      vim.keymap.set('n', 'gp', ':HopPattern<cr>', { desc = 'Hop to pattern' })
    end,
  },
}
