-- :PackerSync
lvim.plugins = {
    { "jcypret/nord-vim-midnight" },
}

lvim.colorscheme = "nord"
lvim.format_on_save.enabled = false
lvim.builtin.autopairs.active = false

-- tab indent (2)
vim.opt.autoindent = true
vim.cmd("set noexpandtab")
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.timeoutlen = 250

-- save with Ctrl+S
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- switch between tabs
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.lualine = vim.tbl_extend('keep', lvim.builtin.lualine, {
	options = {
		component_separators = '|',
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
		lualine_b = { 'filename', 'branch' },
	},
})
