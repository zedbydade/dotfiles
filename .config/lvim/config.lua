-- vim general
vim.opt.relativenumber = true
vim.opt.backup = false
vim.opt.fileencoding = 'utf-8'
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.ttyfast = true
vim.opt.hidden = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.encoding = 'utf-8'
vim.termenconding = 'utf-8'
vim.clipboard = 'unnamed'

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-night"
-- to disable icons and use a minimalist setup, uncomment the following

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<g-h>"] = ":diffget //3"
lvim.keys.normal_mode["<g-u>"] = ":diffget //2"
lvim.keys.normal_mode["<g-s>"] = ":G"

local banner = {
  '',
  '    ████▌█████▌█ ████████▐▀██▀    ',
  '  ▄█████ █████▌ █ ▀██████▌█▄▄▀▄   ',
  '  ▌███▌█ ▐███▌▌  ▄▄ ▌█▌███▐███ ▀  ',
  ' ▐ ▐██  ▄▄▐▀█   ▐▄█▀▌█▐███▐█      ',
  '   ███ ▌▄█▌  ▀  ▀██  ▀██████▌     ',
  '    ▀█▌▀██▀ ▄         ███▐███     ',
  '     ██▌             ▐███████▌    ',
  '     ███     ▀█▀     ▐██▐███▀▌    ',
  '     ▌█▌█▄         ▄▄████▀ ▀      ',
  '       █▀██▄▄▄ ▄▄▀▀▒█▀█           ',
  '',
}

lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.alpha.dashboard.section.header.val = banner

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
  "javascript",
  "json",
  "lua",
  "typescript",
  "tsx",
  "java",
  "yaml",
  "ruby"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

lvim.plugins = {
  { "tpope/vim-rails" },
  { "airblade/vim-gitgutter" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-endwise" },
  { "terryma/vim-multiple-cursors" },
  { "folke/tokyonight.nvim" },
  { "wakatime/vim-wakatime" }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
