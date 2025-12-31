return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- { "wakatime/vim-wakatime", lazy = false },

    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        lazy = false,
        -- opts = {}
    },

    {
        "Leon-Degel-Koehn/qmlformat.nvim",
    },
    {
        "mg979/vim-visual-multi",
        -- event = "VeryLazy",
        -- init = function()
        --     vim.g.VM_maps = {
        --         ["Find Under"] = "<C-d>", -- Use Ctrl-d like VSCode
        --         ["Find Subword Under"] = "<C-d>",
        --     }
        -- end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                ignore = false,
            },
            view = {
                side = "right",
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "bash",
                "fish",
            },
        },
    },
}
