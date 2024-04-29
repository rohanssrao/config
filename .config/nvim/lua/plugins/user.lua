return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.options.opt.relativenumber = false
      return opts
    end
  },
  {
    "AstroNvim/astroui",
    opts = { colorscheme = "nord" },
  },
  { "jcypret/nord-vim-midnight" },
  { "goolord/alpha-nvim", enabled = false },
}
