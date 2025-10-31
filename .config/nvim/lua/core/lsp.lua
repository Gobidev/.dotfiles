vim.lsp.enable("lua_ls")
vim.lsp.enable("stylua")

vim.lsp.enable("ansiblels")

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

vim.lsp.enable('pyright')


vim.diagnostic.config({
  severity = { min = vim.diagnostic.severity.WARN },
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
