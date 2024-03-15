lvim.plugins = {
  { "jcypret/nord-vim-midnight" },
}

lvim.colorscheme = "nord"
lvim.builtin.autopairs.active = false

vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.expandtab = true

vim.opt.timeoutlen = 250

lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":bprev<CR>"

lvim.lsp.installer.setup.automatic_installation = false
