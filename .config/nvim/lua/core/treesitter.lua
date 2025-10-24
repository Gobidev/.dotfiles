require("nvim-treesitter").install({"rust", "lua", "yaml", "json"})
local already_installed = require("nvim-treesitter.config").get_installed('parsers')

local function ts_start(bufnr, parser_name)
	vim.treesitter.start(bufnr, parser_name)
	-- Use regex based syntax-highlighting as fallback as some plugins might need it
	vim.bo[bufnr].syntax = "ON"
	-- Use treesitter for folds
	vim.wo.foldlevel = 99
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo.foldtext = "v:lua.vim.treesitter.foldtext()"
	-- Use treesitter for indentation
	vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end


-- Auto-install and start parsers for any buffer
vim.api.nvim_create_autocmd({ "FileType" }, {
	desc = "Enable Treesitter",
	callback = function(event)
		local bufnr = event.buf
		local filetype = event.match

		-- Skip if no filetype
		if filetype == "" then
			return
		end

		local parser_name = vim.treesitter.language.get_lang(filetype)
		if not parser_name then
			vim.notify(vim.inspect("No treesitter parser found for filetype: " .. filetype),
				vim.log.levels.WARN)
			return
		end

		-- Try to get existing parser
		if not vim.tbl_contains(require("nvim-treesitter.config").get_available(), parser_name) then return end

		-- Check if parser is already installed
		if not vim.tbl_contains(already_installed, parser_name) then
			-- If not installed, install parser asynchronously and start treesitter
			vim.notify("Installing parser for " .. parser_name, vim.log.levels.INFO)
			require("nvim-treesitter").install({ parser_name }):await(
				function()
					ts_start(bufnr, parser_name)
				end
			)
			return
		end

		-- Start treesitter for this buffer
		ts_start(bufnr, parser_name)
	end,
})
