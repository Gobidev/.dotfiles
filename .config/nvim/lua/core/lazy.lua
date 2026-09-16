-- Plugins that are loaded on first use instead of during startup.
-- The lockfile still installs them on a fresh machine (vim.pack reads it on the
-- first `vim.pack.add()` call in core/plugins.lua).
local M = {}

local loaded = {}

local function load(name, spec, setup)
    if loaded[name] then
        return
    end
    loaded[name] = true
    vim.pack.add({ spec })
    if setup then
        setup()
    end
end

-- fzf-lua: loaded from the picker keymaps in core/keymap.lua
function M.fzf_lua()
    load("fzf-lua", "https://github.com/ibhagwan/fzf-lua", function()
        require("fzf-lua").setup()
    end)
end

-- neo-tree: loaded from the explorer keymap in core/keymap.lua
function M.neo_tree()
    load(
        "neo-tree.nvim",
        { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range("3") },
        function()
            require("neo-tree").setup({})
        end
    )
end

-- gitsigns: loaded as soon as a real buffer is read
vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function()
        -- its plugin/ script calls require('gitsigns').setup() itself
        load("gitsigns.nvim", "https://github.com/lewis6991/gitsigns.nvim")
    end,
})

return M
