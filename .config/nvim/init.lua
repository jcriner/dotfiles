--[[

=====================================================================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- TODO: Current status:
-- * Still need to evaluate specific plugins
-- * All my old stuff is ported (little though there was)
-- * Still cleaning up comments and removing unnecessary stuff.
-- * Need to move my plugins to the "plugins" directory and use: require('lazy').setup('plugins')

-- Ensure Makefiles get hard tabs like they want 'em.
vim.api.nvim_create_augroup('makefile_settings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'makefile_settings',
  pattern = 'make',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 0
  end,
})

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins you can run
--    :Lazy update
--
require('lazy').setup({
  'nmac427/guess-indent.nvim', -- detect tabstop and shiftwidth automatically

  -- colorscheme plugins and preferences.
  -- TODO: Make it so I can ensure specific things are installed, but not used
  require 'plugins.colorschemes',

  -- "hop" to word/pattern via gw/gp keybindings
  require 'plugins.hop',

  -- "show available keybindings in a pop-up as you type."
  require 'kickstart.plugins.which-key',

  -- :keyanalyzer to view current keybindings.
  -- NOTE: This requires a prefix such as <leader> to see anything. That
  -- limitation makes this much less handy to me. But harmless for now.
  --
  -- use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  { 'meznaric/key-analyzer.nvim', opts = {} },

  -- This is where I get surround commands and improved textobjects.
  -- NOTE: I used to get autopairs from this, but it has some issues.
  require 'kickstart.plugins.mini',

  -- Autopairs works better than the mini.nvim equivalent.
  require 'kickstart.plugins.autopairs',

  -- "Highlight, edit, and navigate code"
  require 'kickstart.plugins.treesitter',

  -- "Neo-tree is a Neovim plugin to browse the file system"
  require 'kickstart.plugins.neo-tree',

  -- "Lightweight yet powerful formatter plugin."
  require 'kickstart.plugins.conform',

  -- "telescope is a highly-extendable fuzzy finder over lists."
  -- This configures various searches over buffers, help options, etc.
  require 'kickstart.plugins.telescope',

  -- Configure LSPs. Mason is used to install needed LSPs. Any configuration
  -- per server is handled within. (Also uses Mason to install things like
  -- stylua.)
  require 'kickstart.plugins.lspconfig',

  -- Autocomplete, LuaSnip
  require 'kickstart.plugins.blink-cmp',

  -- "Deep buffer integration for Git"
  -- require 'kickstart.plugins.gitsigns',

  -- require 'kickstart.plugins.todo-comments',
}, {
  -- This can be removed, I think. TODO: Read lazy.nvim docs on ui.
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
