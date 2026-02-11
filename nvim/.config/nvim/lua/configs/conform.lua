local options = {
   formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },

      javascript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      jsonc = { "biome", "prettier", stop_after_first = true },

      css = { "prettier" },
      html = { "prettier" },
      astro = { "prettier" },
      markdown = { "prettier" },
      python = { "ruff_format" },
      svelte = { "prettier" },
   },

   formatters = {},

   format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
   },
}

return options
