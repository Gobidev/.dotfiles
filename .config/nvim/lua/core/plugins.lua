vim.pack.add({
    -- theme and line
    "https://github.com/gruvbox-community/gruvbox",
    "https://github.com/nvim-lualine/lualine.nvim",
    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    -- mason
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/RubixDev/mason-update-all",
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
    -- telescope alternative
    "https://github.com/ibhagwan/fzf-lua",
    -- file browser
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
    -- neo-tree dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    -- git
    "https://github.com/lewis6991/gitsigns.nvim",
})

require("mason").setup()
require("mason-update-all").setup()
require("fzf-lua").setup()
require("nvim-surround").setup()
require("luasnip").setup({ enable_autosnippets = true })
require("neo-tree").setup({})

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
