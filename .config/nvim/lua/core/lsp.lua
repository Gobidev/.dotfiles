vim.lsp.config.rust_analyzer = {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
                command = "clippy"
            }
        }
    }
}

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ansiblels",
        "rust_analyzer",
        "clangd",
        "pyright",
        "bashls"
    },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
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
