dofile(vim.g.base46_cache .. "blink")

local opts = {
    cmdline = { enabled = false },
    appearance = { nerd_font_variant = "normal" },
    fuzzy = { implementation = "rust" },
    sources = { default = { "lsp", "buffer", "snippets", "path" } },

    keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
    },

    completion = {
        -- ghost_text = { enabled = true },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "single" },
        },

        -- nvchad's cmp ui
        menu = require("nvchad.blink").menu,
    },
}

return opts
