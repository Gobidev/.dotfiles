-- Update treesitter parsers whenever the plugin itself is installed or updated
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local spec = ev.data.spec
        if spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.pack.add({
    -- theme and line
    "https://github.com/gruvbox-community/gruvbox",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/linrongbin16/lsp-progress.nvim",
    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    -- mason
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/RubixDev/mason-update-all",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    -- formatting
    "https://github.com/stevearc/conform.nvim",
    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

    -- blink
    "https://github.com/saghen/blink.download",
    -- completion
    { src = "https://github.com/saghen/blink.cmp", version = "v1.7.0" },

    -- snippets
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/windwp/nvim-autopairs",

    -- better editing
    "https://github.com/kylechui/nvim-surround",
    -- dependencies of lazily loaded plugins (see core/lazy.lua)
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

require("mason").setup()
require("mason-update-all").setup()
require("mason-tool-installer").setup({
    ensure_installed = {
        "stylua",
        "shfmt",
        "ruff",
        "prettier",
        "clang-format",
        "ansible-lint",
    },
})
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        python = { "ruff_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        c = { "clang-format" },
        cpp = { "clang-format" },
    },
})
require("lsp-progress").setup()
require("nvim-surround").setup()
require("luasnip").setup({ enable_autosnippets = true })

require("nvim-autopairs").setup({
    disable_filetype = { "fzf" },
})

-- Blink configuration
require("blink.cmp").setup({
    keymap = {
        ["<Tab>"] = { "accept", "fallback" },
    },
    completion = { accept = { auto_brackets = { enabled = true } } }
})
