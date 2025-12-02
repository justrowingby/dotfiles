-- requires nvim 0.11.x

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
      -- see https://github.com/nvim-treesitter/nvim-treesitter#quickstart
      "nvim-treesitter/nvim-treesitter",
      branch = 'main',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        -- a list of parser names, or "all"
        ensure_installed = {
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
          'racket',
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
        },
        sync_install = false,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        additional_vim_regex_highlighting = false,
      }
    },
    {
      "HiPhish/rainbow-delimiters.nvim",
      opts = {
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
      },
      config = function(_, opts)
        -- needed bc lazy fails to guess the setup module name
        require("rainbow-delimiters.setup").setup(opts)
      end,
    },
    {
      -- for catpuccin-frappe; has to be set as colorscheme below
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
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

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin-frappe"

local autocmd = vim.api.nvim_create_autocmd

autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})
