return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      bigfile = { enabled = true },
      explorer = { enabled = true },
      picker = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      indent = { enabled = true },
    },
  },
  {
    "saghen/blink.cmp",
    version = "1.*", -- prebuilt fuzzy matcher: stable branch, not experimental v2
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = { preset = "default" },
      completion = { documentation = { auto_show = true, auto_show_delay_ms = 300 } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    build = ":TSUpdate",
    config = function()
      -- Current nvim-treesitter API (not the legacy configs.setup API).
      local langs = { "java", "kotlin", "yaml", "json", "bash", "lua", "markdown" }
      require("nvim-treesitter").install(langs)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
}
