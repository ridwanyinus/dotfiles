require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "astro", "cssls", "tsserver", "lua_ls", "jsonls", "emmet_ls", "eslint" }

-- HTML settings
vim.lsp.config("html", {
   filetypes = { "html", "htmldjango", "blade", "eruby" },
})

-- CSS settings
vim.lsp.config("cssls", {
   settings = {
      css = {
         validate = true,
         lint = {
            unknownAtRules = "ignore", -- Ignore @tailwind warnings
         },
      },
      scss = {
         validate = true,
      },
      less = {
         validate = true,
      },
   },
})

-- Tailwind settings
vim.lsp.config("tailwindcss", {
   filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
   },
})

-- TypeScript/JavaScript settings
vim.lsp.config("tsserver", {
   settings = {
      typescript = {
         inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
         },
      },
      javascript = {
         inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
         },
      },
   },
})

-- Emmet settings
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

vim.lsp.enable(servers)

-- read :h vim.lspconfig for changing options of lsp servers
-- help lspconfig-all
