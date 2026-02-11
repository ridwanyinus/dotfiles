return {
   cmd = { "typescript-language-server", "--stdio" },
   filetypes = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
   },
   init_options = {
      preferences = {
         includeInlayParameterNameHints = "all",
         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
         includeInlayFunctionParameterTypeHints = true,
         includeInlayVariableTypeHints = false,
         includeInlayPropertyDeclarationTypeHints = true,
         includeInlayFunctionLikeReturnTypeHints = true,
         includeInlayEnumMemberValueHints = true,
      },
   },
   settings = {
      javascript = {
         inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = false,
         },
      },
      typescript = {
         inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = false,
         },
      },
   },
   handlers = {
      ["workspace/applyEdit"] = function()
         return { applied = false }
      end,
   },
}
