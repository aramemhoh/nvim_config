local map = vim.keymap.set
local options = { silent = true }

map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Files" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Grep in project" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "Explorer" })
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document symbols" })
map("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol("") end, { desc = "Workspace symbols" })

-- STS4 special LSP symbol queries. Works after the Spring language server starts.
map("n", "<leader>sb", function() vim.lsp.buf.workspace_symbol("@+") end,
  { desc = "Spring beans" })
map("n", "<leader>se", function() vim.lsp.buf.workspace_symbol("@/") end,
  { desc = "Spring endpoints" })

map("n", "<leader>jt", "<cmd>JavaTestRunCurrentMethod<cr>", { desc = "JUnit current method" })
map("n", "<leader>jc", "<cmd>JavaTestRunCurrentClass<cr>", { desc = "JUnit current class" })
map("n", "<leader>jd", "<cmd>JavaTestDebugCurrentMethod<cr>", { desc = "JUnit debug current method" })
map("n", "<leader>jm", "<cmd>JavaRefactorExtractMethod<cr>", { desc = "Extract method" })
map("n", "<leader>jv", "<cmd>JavaRefactorExtractVariable<cr>", { desc = "Extract variable" })
map("n", "<leader>jr", "<cmd>JavaRunnerRunMain<cr>", { desc = "Run main application" })
map("n", "<leader>jp", "<cmd>JavaProfile<cr>", { desc = "Java profiles" })

map("n", "<F5>", function() require("dap").continue() end, { desc = "DAP start/continue" })
map("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "DAP breakpoint" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP step over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "DAP step into" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP UI" })
map("n", "<leader>dt", function() require("dap").terminate() end, { desc = "DAP terminate" })

local function gradle(args)
  local root = vim.fn.getcwd()
  if vim.fn.filereadable(root .. "/gradlew") == 0 then
    vim.notify("No gradlew in cwd. Launch Neovim from the Gradle root.", vim.log.levels.WARN)
    return
  end
  local overseer = require("overseer")
  overseer.new_task({
    cmd = root .. "/gradlew",
    args = args,
    cwd = root,
    components = { "default" },
  }):start()
  overseer.open({ enter = false })
end
map("n", "<leader>gb", function() gradle({ "build" }) end, { desc = "Gradle build" })
map("n", "<leader>gt", function() gradle({ "test" }) end, { desc = "Gradle test" })
map("n", "<leader>gg", function()
  vim.ui.input({ prompt = "Gradle task(s): ", default = "tasks" }, function(value)
    if value and value:match("%S") then
      gradle(vim.split(vim.trim(value), "%s+"))
    end
  end)
end, { desc = "Gradle custom task" })
map("n", "<leader>go", "<cmd>OverseerToggle<cr>", { desc = "Gradle tasks panel" })
