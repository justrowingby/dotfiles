-- requires nvim 0.11.7+

require("lazybootstrap")

local opt = vim.opt

opt.list = true
opt.listchars = {
  tab = "»-",
  multispace = "·",
  leadmultispace = "▏ ",
  nbsp = "␣",
  trail = "▒",
  precedes = "<",
  extends = ">",
}
opt.ignorecase = true
opt.smartcase = true

opt.tabstop = 2
opt.shiftwidth = 0  -- use tabstop
opt.softtabstop = 0 -- use tabstop
opt.expandtab = true

opt.wrap = false
opt.undofile = true
-- dup of mode in status line
opt.showmode = false
-- aggressively write swap files for minimal data loss in case of crash
opt.updatetime = 300

local os_name = vim.loop.os_uname().sysname
if vim.g.neovide then
  if os_name == "Darwin" then
    -- Cmd-c,Cmd-v should behave as expected using + register
    vim.keymap.set('v', '<D-c>', '"+y')             -- Copy
    vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+P')    -- Paste normal and visual mode
    vim.keymap.set({ 'i', 'c' }, '<D-v>', '<C-R>+') -- Paste insert and command mode
    vim.keymap.set('t', '<D-v>', [[<C-\><C-N>"+P]]) -- Paste terminal mode
    -- Cmd-s should save bc why not :3
    vim.keymap.set('n', '<D-s>', ':w<CR>')          -- Save
  end
  -- correct font rendering for hidpi screens
  vim.g.neovide_font_hinting = 'none'
  vim.g.neovide_font_edging = 'subpixelantialias'
  -- make cursor animation snappy short
  vim.g.neovide_cursor_animation_length = 0.010
  vim.g.neovide_cursor_trail_size = 0.10
  -- make scrolling animation faster
  vim.g.neovide_scroll_animation_length = 0.08
  -- discourage unintentional sidescrolling
  vim.g.neovide_touch_deadzone = 10.0
end

vim.lsp.enable({   -- nixpkgs name
  "gopls",         -- gopls
  "lua_ls",        -- lua-language-server
  "rust_analyzer", -- rust-analyzer
  "ts_ls",         -- typescript,typescript-language-server
})

require("lazy").setup({
  spec = {
    -- import plugins here
    { "neovim/nvim-lspconfig", }, -- necessary lsp defaults
    { "tpope/vim-fugitive", },    -- :Git
    { "tpope/vim-rhubarb", },     -- github support for fugitive :GBrowse
    { "NicolasGB/jj.nvim", },     -- :J, :Jdiff, :Jhdiff
    {
      -- :DiffviewOpen <commit-ish-A>[..<commit-ish-B>] [options] [ -- {paths...}]
      -- :[bufrange]DiffviewFileHistory [paths] [options]
      -- see for more https://github.com/sindrets/diffview.nvim
      "sindrets/diffview.nvim",
    },
    {
      -- :Telescope find_files , :Telescope live grep
      'nvim-telescope/telescope.nvim',
      version = '*',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
    },
    {
      -- see https://github.com/nvim-treesitter/nvim-treesitter/tree/main#installation
      -- parsers installed below
      "nvim-treesitter/nvim-treesitter",
      branch = 'main',
      lazy = false,
      build = ":TSUpdate",
    },
    {
      -- setup color ordering below
      "HiPhish/rainbow-delimiters.nvim",
    },
    {
      -- for catpuccin-frappe; set as colorscheme below
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
    },
    {
      -- minimal statusline, setup below
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
      -- modal commandline
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      opts = {},
    },
    {
      -- lua library imports for editing vim config
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  install = {
    -- install missing plugins on startup
    missing = true,
    -- colorscheme that lazy.nvim ui will attempt to load if starting an install on startup
    colorscheme = { "catppuccin-frappe" },
  },
  checker = {
    -- do not check for plugin updates periodically
    -- updating the lock file should be a manual human decision,
    -- so that we know when to be on the lookout for regressions
    enabled = false,
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "zipPlugin",
      },
    },
  },
})

-- colorscheme should be loaded before lualine
vim.cmd.colorscheme "catppuccin-frappe"

require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
}

require('telescope').setup {
  -- ...
}

require 'nvim-treesitter'.install {
  'bash',
  'c',
  'clojure',
  'commonlisp',
  'cpp',
  'css',
  'diff',
  'fish',
  'git_config',
  'git_rebase',
  'gitignore',
  'go',
  'haskell',
  'html',
  'java',
  'javascript',
  'json',
  'lua',
  'markdown_inline',
  'nix',
  'php',
  'prolog',
  'proto',
  'python',
  'query',
  'racket',
  'regex',
  'ruby',
  'rust',
  'ssh_config',
  'swift',
  'systemverilog',
  'typescript',
  'typst',
  'udev',
  'vim',
  'vimdoc',
  'xml',
  'zig',
}

require("rainbow-delimiters.setup").setup({
  highlight = {
    -- use rainbow ordering
    'RainbowDelimiterRed',
    'RainbowDelimiterOrange',
    'RainbowDelimiterYellow',
    'RainbowDelimiterGreen',
    'RainbowDelimiterCyan',
    'RainbowDelimiterBlue',
    'RainbowDelimiterViolet',
  },
})

local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function()
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.treesitter.start()
  end,
})
