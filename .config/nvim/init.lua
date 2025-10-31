if vim.fn.has("nvim-0.12") == 0 then
    vim.notify("NativeVim only supports Neovim 0.12+", vim.log.levels.ERROR)
    return
end

require("core.plugins")
require("core.colors")
require("core.set")
require("core.keymap")
require("core.lualine")
require("core.lsp")
require("core.treesitter")
-- require("core.snippets")
