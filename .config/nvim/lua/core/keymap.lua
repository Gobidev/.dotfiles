-- functions for easier keybinds, todo: use descriptive format like for neotree toggle
local function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend('force', outer_opts, opts or {})
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nmap = bind('n', { noremap = false })
local nnoremap = bind('n')
local vnoremap = bind('v')
local xnoremap = bind('x')
local inoremap = bind('i')

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Simple keybind to toggle Neo-tree
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree<CR>', {
  noremap = true,
  silent = true,
  desc = 'Toggle Neo-tree file explorer'
})

-- fzf-lua
nnoremap('<leader>ff', '<Cmd>FzfLua files<CR>')
nnoremap('<leader>fw', '<Cmd>FzfLua live_grep<CR>')

-- centered jumping
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')
nnoremap('*', '*zz')
nnoremap('#', '#zz')
nnoremap('n', 'nzz')
nnoremap('g*', 'g*zz')
nnoremap('<C-d>', '<C-d>zz')
nnoremap('<C-u>', '<C-u>zz')

-- stop searching
nnoremap('<leader>h', '<cmd>:nohlsearch<CR>')
vnoremap('<leader>h', '<cmd>:nohlsearch<CR>')

-- quick save and quit
nnoremap('<leader>w', '<cmd>:w<CR>')
nnoremap('<leader>q', '<cmd>:q<CR>')

-- delete without yanking
nnoremap('<leader>d', '"_d')
nnoremap('<leader>c', '"_c')
nnoremap('<leader>D', '"_D')
nnoremap('<leader>C', '"_C')

-- splits
nnoremap('<C-w>H', '<cmd>:top vs<CR>')
nnoremap('<C-w>J', '<cmd>:bot sp<CR>')
nnoremap('<C-w>K', '<cmd>:top sp<CR>')
nnoremap('<C-w>L', '<cmd>:bot vs<CR>')

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

vim.keymap.set('n', '<leader>x', '<Cmd>bd<CR>', {
  noremap = true,
  silent = true,
  desc = 'Close current buffer'
})

-- lsp
nnoremap('<leader>lf', vim.lsp.buf.format)
nnoremap('<leader>la', vim.lsp.buf.code_action) -- todo use pretty format
nnoremap('<leader>gd', vim.lsp.buf.definition)
nnoremap('K', vim.lsp.buf.hover)
