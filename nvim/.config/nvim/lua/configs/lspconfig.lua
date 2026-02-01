-- help lspconfig-all
require("nvchad.configs.lspconfig").defaults()

-- vim.diagnostic.config {
--    virtual_lines = false,
--    virtual_text = false,
--    underline = { severity = { min = vim.diagnostic.severity.ERROR } },
--    update_in_insert = false,
--    severity_sort = true,
--    float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--       source = "always",
--       header = "",
--       prefix = "",
--    },
-- }

local servers = { "html", "astro", "cssls", "ts_ls", "lua_ls", "jsonls", "emmet_ls", "eslint", "stylelint_lsp" }

vim.lsp.config("*", {
   root_markers = { ".git" },
   capabilities = {
      textDocument = {
         semanticTokens = {
            multilineTokenSupport = true,
         },
      },
   },
})

vim.lsp.enable(servers)

-- Auto-format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = { "*.lua", "*.ts", "*.tsx", "*.js", "*.jsx", "*.css", "*.html", "*.astro" },
--    callback = function()
--       vim.lsp.buf.format { async = false }
--    end,
-- })
