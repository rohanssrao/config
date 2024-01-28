-- :PackerSync
lvim.plugins = {
    { "jcypret/nord-vim-midnight" },
}

-- general
lvim.colorscheme = "nord"
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.builtin.autopairs.active = false

-- tab to indent
vim.opt.autoindent = true
vim.cmd("set noexpandtab")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
vim.opt.timeoutlen = 250
-- save with Ctrl+S
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- switch between tabs
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- :LvimSyncCorePlugins
lvim.builtin.lualine.options = {
  component_separators = '|',
  section_separators = { left = '', right = '' },
}
lvim.builtin.lualine.sections = {
  lualine_a = {
    { 'mode', separator = { left = '' }, right_padding = 2 },
  },
  lualine_b = { 'filename', 'branch' },
  lualine_c = { 'fileformat' },
  lualine_x = {},
  lualine_y = { 'filetype', 'progress' },
  lualine_z = {
    { 'location', separator = { right = '' }, left_padding = 2 },
  },
}

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
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
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.treesitter.highlight.enable = true

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

