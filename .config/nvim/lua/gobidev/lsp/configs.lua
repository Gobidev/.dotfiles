local handlers = require('gobidev.lsp.handlers')
local default_opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { 'utf-16' }

local function merge_opts(new_opts) return vim.tbl_deep_extend('force', new_opts, default_opts) end

local function with_settings(settings)
    return merge_opts {
        settings = settings,
    }
end

local default_no_formatter = merge_opts {
    init_options = {
        provideFormatter = false,
    },
}

-- Mason: automatic installation of LSPs and null-ls sources
require('mason').setup {
    ui = {
        border = 'rounded',
        icons = {
            package_installed = '✓',
            package_pending = '⟳',
            package_uninstalled = '✗',
        },
    },
}
require('mason-lspconfig').setup { automatic_installation = true }
require('gobidev.lsp.null_ls')
require('mason-null-ls').setup { automatic_installation = true }
require('mason-update-all').setup()

require('crates').setup {
    date_format = '%d.%m.%Y',
    notification_title = 'crates.nvim',
    popup = {
        border = 'rounded',
        keys = {
            hide = { 'q', '<esc>', '<C-k>' },
        },
    },
    null_ls = {
        enabled = true,
        name = 'crates.nvim',
    },
}

require('lspconfig').rust_analyzer.setup(with_settings {
    ['rust-analyzer'] = {
        checkOnSave = { command = 'clippy' },
    },
})
require('lspconfig').vimls.setup(default_opts)
require('lspconfig').bashls.setup(default_opts)
require('lspconfig').ts_ls.setup(default_opts)
require('lspconfig').lua_ls.setup(with_settings {
    Lua = {
        runtime = {
            version = 'LuaJIT',
        },
        diagnostics = {
            globals = { 'vim' },
        },
        telemetry = {
            enable = false,
        },
    },
})
-- require('lspconfig').pylsp.setup(default_opts)
-- require('lspconfig').pylyzer.setup(default_opts)
require('lspconfig').pyright.setup(default_opts)
require('lspconfig').dockerls.setup(default_opts)
require('lspconfig').ansiblels.setup(default_opts)
require("lspconfig").golangci_lint_ls.setup(default_opts)
require("lspconfig").gopls.setup(default_opts)
require('lspconfig').jdtls.setup(default_opts)
-- require('lspconfig').kotlin_language_server.setup(default_opts)
-- require('lspconfig').gdscript.setup(default_opts)
require('lspconfig').clangd.setup { capabilities = capabilities, on_attach = handlers.on_attach }
require('lspconfig').taplo.setup(default_opts)
-- require('lspconfig').ltex.setup(with_settings {
--     ltex = {
--         additionalRules = {
--             enablePickyRules = true,
--             motherTongue = 'de-De',
--         },
--     },
-- })
-- require('lspconfig').texlab.setup(with_settings {
--     texlab = {
--         build = {
--             args = {
--                 '-xelatex',                 -- Build with xelatex
--                 '-pdfxe',                   -- Build with xelatex
--                 '-interaction=nonstopmode', -- Ignore errors
--                 '-synctex=1',               -- Enable SyncTeX
--                 '-pv',                      -- Open preview
--                 '%f',
--             },
--             onSave = true, -- Build on save
--         },
--         forwardSearch = {
--             -- Use zathura for preview
--             executable = 'zathura',
--             args = { '--synctex-forward', '%l:1:%f', '%p' },
--         },
--
--         -- Set latexindent as formatter
--         bibtexFormatter = 'latexindent',
--         latexFormatter = 'latexindent',
--
--         -- Enable chktex lints
--         chktex = {
--             onOpenAndSave = true,
--             onEdit = true,
--         },
--     },
-- })
-- require('lspconfig').tsserver.setup(default_no_formatter)
-- require('lspconfig').cssls.setup(default_no_formatter)
require('lspconfig').html.setup(default_no_formatter)
require('lspconfig').jsonls.setup(default_no_formatter)
require('lspconfig').tinymist.setup(default_opts)
require('prettier').setup {
    bin = 'prettier',
    filetypes = {
        'css',
        'scss',
        'html',
        'javascript',
        'typescript',
        'json',
        'json5',
        'svelte',
    },

    -- Do not restrict prettier to npm projects
    ['null-ls'] = {
        condition = function() return true end,
    },

    -- Default prettier settings
    arrow_parens = 'avoid',
    semi = false,
    single_quote = true,
    tab_width = 4,
    trailing_comma = 'all',
}
