-- ========================
-- Core Settings
-- ========================
vim.opt.termguicolors   = true
vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.cursorline      = true
vim.opt.colorcolumn     = "80"
vim.opt.clipboard       = "unnamedplus"
vim.opt.laststatus      = 3
vim.opt.showtabline     = 2
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "if_many"
    },
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- ========================
-- snacks
-- ========================
local Snacks = require("snacks")

-- use a module-level variable to track setup
if not vim.g.snacks_setup_done then
    Snacks.setup({
        styles = { float = { border = "rounded" } },
        animate = { enabled = false },
        dashboard = { enabled = false },
        image = { enabled = true },
        indent = {
            enabled = true,
            indent = { only_scope = false },
            chunk = {
                enabled = true,
                only_current = false,
                priority = 200,
                hl = "SnacksIndentChunk",
                char = {
                    corner_top = "╭",
                    corner_bottom = "╰",
                    horizontal = "",
                    vertical = "│",
                    arrow = "",
                },
            },
        },
        picker = { enabled = true, matcher = { history_bonus = true } },
        bufferline = { enabled = true },
        statusline = { enabled = true },
    })

    vim.g.snacks_setup_done = true
end

-- toggle colorschemes
local colorschemes = { "cyberdream", "oxocarbon", "onedark" }
local current_index = 1
function ToggleColorscheme()
    current_index = current_index % #colorschemes + 1 
    local scheme = colorschemes[current_index]

    if scheme == "cyberdream" then
        local ok, cd = pcall(require, "cyberdream")
        if ok then cd.setup({ transparent = true }) end
    elseif scheme == "onedark" then
        local ok, od = pcall(require, "onedark")
        if ok then od.setup({ style = "dark" }) end
    end
    vim.cmd("colorscheme " .. scheme)
    vim.notify("colorscheme " .. scheme)
end

-- ========================
-- Plugin setup
-- ========================
require("trixvim.packer")  -- packer.lua
require("trixvim.lsp")
require("trixvim.remap")

-- ========================
-- Treesitter
-- ========================
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python" },
    sync_install = false,

    auto_install = true,
    ignore_install = { "javascript" },
    highlight = {
        enable = true,

        disable = { "c", "rust" },
        additional_vim_regex_highlighting = false,
    },
}

-- ========================
-- Noice
-- ========================
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,

        inc_rename = false,
        lsp_doc_border = false,
    },
})

-- ========================
-- Bufferline 
-- ========================

require("bufferline").setup({
  options = {
    mode = "tabs",
    right_mouse_command = "horizontal sbuffer %d",
    middle_mouse_command = "vertical sbuffer %d",
    indicator = { style = "underline" },
    modified_icon = "",
    color_icons = true,
    separator_style = "slope",
  },
})

-- ========================
-- virtcolumn 
-- ========================

require("virt-column").setup({
  char = "|",
  virtcolumn = "80",
})

-- ========================
-- lualine 
-- ========================

require("lualine").setup({
  options = { section_separators = "", component_separators = "" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      { "diff", symbols = { added = "+ ", modified = " ", removed = " " } },
      "diagnostics"
    },
    lualine_c = {
      { "filename", symbols = { modified = "", readonly = "", unnamed = "", newfile = "" } }
    },
    lualine_x = { { "encoding", show_bomb = true }, "fileformat", { "filetype", icon_only = true } },
    lualine_y = {},
    lualine_z = { { "datetime", style = "%d/%m/%Y" } }
  },
  inactive_sections = {
    lualine_a = {}, lualine_b = {},
    lualine_c = { { "filename", symbols = { modified = "", readonly = "", unnamed = "", newfile = "" } } },
    lualine_x = {}, lualine_y = {}, lualine_z = {}
  },
})

-- ========================
-- dropbar
-- ========================
local dropbar_api = require("dropbar.api")
