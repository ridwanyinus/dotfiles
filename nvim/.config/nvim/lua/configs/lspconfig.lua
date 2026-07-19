vim.lsp.config("*", {
   capabilities = require("blink.cmp").get_lsp_capabilities {
      textDocument = {
         foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
         },
      },
   },
})

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
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.WARN] = "",
         [vim.diagnostic.severity.INFO] = "",
         [vim.diagnostic.severity.HINT] = "",
      },
      numhl = {
         [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
         [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
         [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
         [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      },
   },
}
local function apply_code_action_sync(bufnr, client, action_kind)
   local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
   params.context = { only = { action_kind }, diagnostics = {} }

   local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)

   if not results then
      return
   end

   for _, res in pairs(results) do
      for _, action in pairs(res.result or {}) do
         if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
         elseif action.command then
            client:exec_cmd(action.command)
         end
      end
   end
end

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Document highlight
      vim.keymap.set("n", "K", function()
         vim.lsp.buf.hover { border = border }
      end, { buffer = bufnr, desc = "LSP Hover (Rounded)" })
      vim.keymap.set("i", "<C-k>", function()
         vim.lsp.buf.signature_help { border = border }
      end, { buffer = bufnr, desc = "LSP Signature Help" })

      if client and client.name == "biome" then
         vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
               apply_code_action_sync(bufnr, client, "source.organizeImports")
            end,
         })
      end
   end,
})

vim.lsp.config("ruff", {
   filetypes = { "python" },
})

vim.lsp.config("pyright", {
   settings = {
      python = {
         analysis = {
            autoSearchPaths = true,
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
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
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "sass",
      "vue",
      "scss",
      "typescript",
      "typescriptreact",
   },
   init_options = {
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = "always",
      html = {
         options = {
            ["bem.enabled"] = true,
         },
      },
   },
})

vim.lsp.config("biome", {
   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
   single_file_support = true,
})

vim.lsp.config("ts_ls", {
   settings = {
      javascript = {
         suggest = {
            autoImports = true,
         },
      },
   },
   init_options = {
      preferences = {
         includeCompletionsForModuleExports = true,
         includeCompletionsWithInsertText = true,
         includeAutomaticOptionalChainCompletions = true,
         importModuleSpecifierPreference = "non-relative",
      },
   },
})

local servers = {
   "pyright",
   "clangd",
   "html",
   "tailwindcss",
   "astro",
   "yamlls",
   "cssls",
   "ts_ls",
   "lua_ls",
   "jsonls",
   "emmet_ls",
   "ruff",
   "eslint",
   "biome",
   "stylelint_lsp",
}

vim.lsp.enable(servers)
