-- help lspconfig-all
require("nvchad.configs.lspconfig").defaults()

vim.diagnostic.config {
   virtual_lines = false,
   virtual_text = false,
   underline = { severity = { min = vim.diagnostic.severity.ERROR } },
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
         vim.lsp.buf.hover { border = "rounded" }
      end, { buffer = bufnr, desc = "LSP Hover (Rounded)" })

      vim.keymap.set("i", "<C-k>", function()
         vim.lsp.buf.signature_help { border = "rounded" }
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
   filetypes = {
      "html",
      "astro",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
   },
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
