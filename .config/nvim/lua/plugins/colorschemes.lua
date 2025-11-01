return {
  {
    'folke/tokyonight.nvim',
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      require 'kanagawa'
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'catppuccin/nvim',
    enabled = true,
    priority = 1000,
    config = function()
      -- require 'catppuccin'
      -- vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'darianmorat/gruvdark.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      require('gruvdark').setup()
    end,
  },
  {
    'phha/zenburn.nvim',
    enabled = true,
    priority = 1000,
    config = function()
      require('zenburn').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
