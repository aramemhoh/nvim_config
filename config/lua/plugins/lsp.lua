return {
  { "neovim/nvim-lspconfig" }, -- server definitions for vim.lsp.config in Neovim 0.12
  { "mason-org/mason.nvim", opts = {} },
  { "b0o/SchemaStore.nvim" },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
            validate = true,
            completion = true,
          },
        },
      })
      require("mason-lspconfig").setup({
        ensure_installed = { "yamlls", "jsonls", "bashls" },
        -- Crucial: don't let mason-lspconfig start a second JDTLS.
        automatic_enable = { "yamlls", "jsonls", "bashls" },
      })
    end,
  },
}
