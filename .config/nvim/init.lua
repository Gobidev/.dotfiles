if vim.fn.has("nvim-0.12") == 0 then
    vim.notify("NativeVim only supports Neovim 0.12+", vim.log.levels.ERROR)
    return
end

-- require("core.options")
require("core.plugins")
-- require("core.treesitter")
-- require("core.lsp")
-- require("core.keymap")
require("core.colors")
-- require("core.snippets")
-- require("core.statusline")
