local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
if not pcall(require, "lazy") then
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require("lazy").setup({
  { "AstroNvim/AstroNvim", import = "astronvim.plugins" },
  { "goolord/alpha-nvim", enabled = false },
  { "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.options.opt.relativenumber = false
      opts.options.opt.wrap = true
      opts.mappings.n.H = { function() require("astrocore.buffer").nav(-vim.v.count1) end }
      opts.mappings.n.L = { function() require("astrocore.buffer").nav(vim.v.count1) end }
      opts.mappings.v["<"] = { "<gv" }
      opts.mappings.v[">"] = { ">gv" }
      opts.autocmds.wrapMarkdown = {
        {
          event = { "BufEnter" },
          pattern = { "*.md" },
          callback = function() vim.opt_local.wrap = true end,
        }
      }
      return opts
    end
  },
  { "akinsho/toggleterm.nvim", lazy = false, opts = { open_mapping = [[<c-\>]] } },
  { "HiPhish/rainbow-delimiters.nvim" },
})
