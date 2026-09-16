local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

local lazy = require("core.lazy")

-- File explorer
map("n", "<leader>e", function()
    lazy.neo_tree()
    vim.cmd("Neotree")
end, "Toggle Neo-tree file explorer")

-- fzf-lua
map("n", "<leader>ff", function()
    lazy.fzf_lua()
    vim.cmd("FzfLua files")
end, "Find files")
map("n", "<leader>fw", function()
    lazy.fzf_lua()
    vim.cmd("FzfLua live_grep")
end, "Live grep")

-- Centered jumping
local centered = {
    n = "nzz",
    N = "Nzz",
    ["*"] = "*zz",
    ["#"] = "#zz",
    ["g*"] = "g*zz",
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",
}
for lhs, rhs in pairs(centered) do
    map("n", lhs, rhs, "Jump and center")
end

-- Stop searching
map("n", "<leader>h", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("v", "<leader>h", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Quick save and quit
map("n", "<leader>w", "<cmd>w<CR>", "Save buffer")
map("n", "<leader>q", "<cmd>q<CR>", "Quit window")

-- Delete without yanking
map("n", "<leader>d", '"_d', "Delete without yanking")
map("n", "<leader>c", '"_c', "Change without yanking")
map("n", "<leader>D", '"_D', "Delete to end of line without yanking")
map("n", "<leader>C", '"_C', "Change to end of line without yanking")

-- Splits
map("n", "<C-w>H", "<cmd>top vs<CR>", "Split left")
map("n", "<C-w>J", "<cmd>bot sp<CR>", "Split below")
map("n", "<C-w>K", "<cmd>top sp<CR>", "Split above")
map("n", "<C-w>L", "<cmd>bot vs<CR>", "Split right")

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<S-h>", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "<leader>x", "<cmd>bd<CR>", "Close current buffer")

-- LSP
map("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, "Format buffer")
map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")
map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
map("n", "<leader>lr", vim.lsp.buf.rename, "Rename symbol")
map("n", "K", vim.lsp.buf.hover, "Hover documentation")
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, "Previous diagnostic")
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, "Next diagnostic")
