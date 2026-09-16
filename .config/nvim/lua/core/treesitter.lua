local parsers = {
    "rust",
    "java",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "javascript",
    "typescript",
    "python",
    "yaml",
    "json",
    "toml",
    "bash",
    "c",
    "diff",
    "gitignore",
    "go",
    "haskell",
    "nginx",
}

require("nvim-treesitter").install(parsers)

local function ts_start(bufnr, parser_name)
    vim.treesitter.start(bufnr, parser_name)

    -- Use regex based syntax-highlighting as fallback as some plugins might need it
    vim.bo[bufnr].syntax = "ON"

    -- Use treesitter for indentation (experimental)
    vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Use treesitter for folds (window-local options)
    for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
        vim.wo[win].foldlevel = 99
        vim.wo[win].foldmethod = "expr"
        vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[win].foldtext = "v:lua.vim.treesitter.foldtext()"
    end
end

-- Install and start parsers on demand for any buffer
vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable Treesitter",
    callback = function(event)
        local bufnr = event.buf
        local filetype = event.match

        if filetype == "" then
            return
        end

        local parser_name = vim.treesitter.language.get_lang(filetype)
        if not parser_name then
            vim.notify("No treesitter parser found for filetype: " .. filetype, vim.log.levels.WARN)
            return
        end

        -- Actually available parsers (managed by nvim-treesitter)
        if not vim.tbl_contains(require("nvim-treesitter.config").get_available(), parser_name) then
            return
        end

        -- Check if the parser is already installed on disk
        local installed = require("nvim-treesitter.config").get_installed("parsers")
        if not vim.tbl_contains(installed, parser_name) then
            vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
            require("nvim-treesitter").install({ parser_name }):await(function()
                ts_start(bufnr, parser_name)
            end)
            return
        end

        ts_start(bufnr, parser_name)
    end,
})
