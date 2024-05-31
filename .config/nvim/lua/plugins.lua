return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.options.opt.relativenumber = false
      return opts
    end
  },
  { "goolord/alpha-nvim", enabled = false },
  { "akinsho/toggleterm.nvim", lazy = false, opts = { open_mapping = [[<c-\>]] } },
}
