-- Shared settings applied to every server
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Per-server configuration lives in `after/lsp/<server>.lua`

-- mason-lspconfig automatically enables installed servers via `vim.lsp.enable()`
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ansiblels",
        "rust_analyzer",
        "clangd",
        "pyright",
        "bashls",
    },
    automatic_enable = true,
})

vim.diagnostic.config({
    severity = { min = vim.diagnostic.severity.WARN },
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
