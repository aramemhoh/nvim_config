return {
  {
    "nvim-java/nvim-java",
    -- nvim-java uses its own lazy.lua manifest to load the supported
    -- version of spring-boot.nvim, nui.nvim and nvim-dap.
    config = function()
      local java_home = vim.env.JAVA_HOME
      local jdk = { auto_install = true, version = "21" }
      if java_home and java_home ~= "" and vim.fn.isdirectory(java_home) == 1 then
        jdk = { auto_install = false, version = "21", path = java_home }
      end
      require("java").setup({ jdk = jdk })
      -- One Java language server per workspace, controlled by nvim-java.
      vim.lsp.enable("jdtls")
    end,
  },
}
