return {
   ensure_installed = {
      "vim",
      "http",
      "scss",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "markdown",
      "json",
      "markdown_inline",
      "bash",
      "fish",
      "lua",
   },
   auto_install = true,
   autopairs = { enable = true },
   -- autotag = { enable = true },
   highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
   },
   rainbow = {
      enable = true,
      extended_mode = false,
      max_file_lines = nil,
   },
   markdown_inline = { enable = true },
   context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
         tsx = {
            jsx_element = {
               __default = "{/* %s */}",
               __parent = {
                  parenthesized_expression = "// %s",
               },
            },
         },
         javascript = {
            __default = "// %s",
            jsx_element = "{/* %s */}",
            jsx_fragment = "{/* %s */}",
            jsx_attribute = "// %s",
            comment = "// %s",
            __parent = {
               -- if a node has this as the parent, use the `//` commentstring
               jsx_expression = "// %s",
            },
         },
      },
   },
}
