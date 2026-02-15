-- help lspconfig-all
require("nvchad.configs.lspconfig").defaults()

local border = {
   { "┌", "FloatBorder" },
   { "─", "FloatBorder" },
   { "┐", "FloatBorder" },
   { "│", "FloatBorder" },
   { "┘", "FloatBorder" },
   { "─", "FloatBorder" },
   { "└", "FloatBorder" },
   { "│", "FloatBorder" },
}
vim.diagnostic.config {
   virtual_lines = false,
   virtual_text = false,
   underline = true,
   -- underline = { severity = { min = vim.diagnostic.severity.WARN } },
   update_in_insert = false,
   severity_sort = true,
   float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
   },
}

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local bufnr = args.buf

      vim.keymap.set("n", "K", function()
         vim.lsp.buf.hover { border = border }
      end, { buffer = bufnr, desc = "LSP Hover (Rounded)" })

      vim.keymap.set("i", "<C-k>", function()
         vim.lsp.buf.signature_help { border = border }
      end, { buffer = bufnr, desc = "LSP Signature Help" })
   end,
})

vim.lsp.config("pyright", {
   settings = {
      python = {
         analysis = {
            autoSearchPaths = true,
            typeCheckingMode = "basic",
         },
      },
   },
})

vim.lsp.config("stylelint_lsp", {
   filetypes = { "css", "scss", "less", "sass" },
   settings = {
      stylelintplus = {
         autoFixOnSave = true,
         autoFixOnFormat = true,
      },
   },
})

vim.lsp.config("emmet_ls", {
   filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue" },
   init_options = {
      html = {
         options = {
            ["bem.enabled"] = true,
         },
      },
   },
})

local servers = {
   "pyright",
   "clangd",
   "html",
   "tailwindcss",
   "astro",
   "cssls",
   "ts_ls",
   "lua_ls",
   "jsonls",
   "emmet_ls",
   "eslint",
   "stylelint_lsp",
}

-- vim.lsp.config("*", {
--    capabilities = {
--       textDocument = {
--          semanticTokens = {
--             multilineTokenSupport = true,
--          },
--       },
--    },
-- })

vim.lsp.enable(servers)

-- Auto-format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = { "*.lua", "*.ts", "*.tsx", "*.js", "*.jsx", "*.css", "*.html", "*.astro" },
--    callback = function()
--       vim.lsp.buf.format { async = false }
--    end,
-- })
