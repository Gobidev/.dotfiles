## Needed packages
- `tree-sitter-cli` (>= 0.26.1)
- a C compiler
- `node` (>= 23, required by a few parsers only)
- `rustup component add rust-analyzer`

Plugins are managed with Neovim 0.12's built-in `vim.pack`. The lockfile
(`nvim-pack-lock.json`) is committed so the exact revisions can be restored on
another machine (`:restart` after pulling; missing plugins are installed from
the lockfile).

## Layout
- `init.lua` bootstraps `lua/core/*`.
- `lua/core/plugins.lua` — eager plugins (installed + loaded at startup).
- `lua/core/lazy.lua` — plugins loaded on first use (`fzf-lua`, `neo-tree`,
  `gitsigns`). Their lockfile entries still install them on a fresh machine.
- `after/lsp/<server>.lua` — per-server LSP configuration, merged on top of the
  definitions shipped by `nvim-lspconfig`.

## Formatting
`conform.nvim` drives formatting (`<leader>lf`, LSP fallback for servers like
`rust_analyzer`). Formatters are installed via `mason-tool-installer`
(`stylua`, `shfmt`, `ruff`, `prettier`, `clang-format`).

