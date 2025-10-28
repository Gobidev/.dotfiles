vim.pack.add({
    -- theme and line
    "https://github.com/gruvbox-community/gruvbox",
    "https://github.com/nvim-lualine/lualine.nvim",
    -- treesitter
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    -- lsp
    "https://github.com/neovim/nvim-lspconfig",
    -- mason
    "https://github.com/mason-org/mason.nvim",

    -- blink
    "https://github.com/saghen/blink.download",
    -- completion
    { src = "https://github.com/saghen/blink.cmp", version = "v1.7.0" },
    -- autopairs
    { src = "https://github.com/saghen/blink.pairs", version = "v0.3.0" },

    -- snippets
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/rafamadriz/friendly-snippets",
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
require("fzf-lua").setup()
require("nvim-treesitter").setup()
require("nvim-surround").setup()
require("luasnip").setup({ enable_autosnippets = true })
require("neo-tree").setup({})
require("blink.cmp").setup({keymap = {
  ["<Tab>"] = { "accept" },
}})
require("blink.pairs").setup({})
