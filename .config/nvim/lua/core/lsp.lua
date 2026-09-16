-- Shared settings applied to every server
vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Per-server configuration lives in `after/lsp/<server>.lua`, except Rust which
-- is handled by rustaceanvim (see below), because it conflicts with lspconfig's
-- rust_analyzer setup.
vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "clippy",
                },
            },
        },
    },
}

-- mason-lspconfig automatically enables installed servers via `vim.lsp.enable()`
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ansiblels",
        "clangd",
        "pyright",
        "bashls",
    },
    automatic_enable = {
        -- rustaceanvim owns the rust-analyzer client
        exclude = { "rust_analyzer" },
    },
})

vim.diagnostic.config({
    severity = { min = vim.diagnostic.severity.WARN },
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
