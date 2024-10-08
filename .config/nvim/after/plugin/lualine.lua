local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then return end

local colors = {
    black = '#282828',
    white = '#ebdbb2',
    red = '#fb4934',
    green = '#b8bb26',
    purple = '#d3869b',
    blue = '#83a598',
    orange = '#fe8019',
    gray = '#a89984',
    darkgray = '#3c3836',
    lightgray = '#504945',
    inactivegray = '#7c6f64',
}

local gruvbox_custom = {
    normal = {
        a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.blue },
    },
    insert = {
        a = { bg = colors.green, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.green },
    },
    visual = {
        a = { bg = colors.purple, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.purple },
    },
    replace = {
        a = { bg = colors.red, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.red },
    },
    command = {
        a = { bg = colors.orange, fg = colors.black, gui = 'bold' },
        b = { bg = colors.lightgray, fg = colors.white },
        c = { bg = colors.darkgray, fg = colors.orange },
    },
    inactive = {
        a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
        b = { bg = colors.darkgray, fg = colors.gray },
        c = { bg = colors.darkgray, fg = colors.gray },
    },
}

local buffers_component = {
    'buffers',
    symbols = {
        alternate_file = '',
    },
}

local diff_component = {
    'diff',
    symbols = {
        added = ' ',
        modified = '柳',
        removed = ' ',
    },
}
local diagnostics_component = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
        error = ' ',
        warn = ' ',
        info = ' ',
        hint = ' ',
    },
    -- TODO: show all diagnostics on click (requires nvim 0.8+)
    -- on_click = function()
    --     require('telescope.bultin').diagnostics()
    -- end,
}

local workspace_diagnostics_component = vim.tbl_deep_extend('force', diagnostics_component, {
    sources = { 'nvim_workspace_diagnostic' },
})

local filename_component = {
    'filename',
    newfile_status = true,
    path = 1,
    symbols = {
        modified = '●',
        readonly = '',
    },
}

local lsp_progress_component = {
    function()
        return require('lsp-progress').progress()
    end,
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = gruvbox_custom,
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        ignore_focus = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diagnostics_component },
        lualine_c = { filename_component },
        lualine_x = { lsp_progress_component, 'filetype', diff_component },
        lualine_y = { 'encoding', 'fileformat' },
        lualine_z = { '%l:%c', '%p%%' },
    },
    inactive_sections = {
        lualine_c = { filename_component },
        lualine_x = { '%l:%c', '%p%%' },
    },
    tabline = {
        lualine_a = { buffers_component },
        lualine_y = { workspace_diagnostics_component },
    },
}
