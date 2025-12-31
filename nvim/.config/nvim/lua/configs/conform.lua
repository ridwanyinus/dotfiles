local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        -- kdl = { "kdlfmt" },
        qml = { "qmlformat" },
    },

    formatters = {
        kdlfmt = {
            command = "kdlfmt",
            args = { "format", "-" },
            stdin = true,
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
