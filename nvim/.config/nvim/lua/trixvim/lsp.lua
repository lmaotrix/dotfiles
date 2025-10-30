-- LSP's are installed here:
require("lspconfig").ruff.setup{}
require("lspconfig").lua_ls.setup{}
require("lspconfig").bashls.setup{}
require("lspconfig").clangd.setup{}


-- Mason nvim config
require("mason").setup()

-- Mason-LSPConfig 
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "ruff",
        "lua_ls",
        "bashls",
        "clangd",
    },
    automatic_installation = true,
})

-- Setup completion engine (nvim-cmp)
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()  -- load friendly snippets

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- LSP servers with capabilities config
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Ruff (python linter)
lspconfig.ruff.setup({
    capabilities = capabilities,
    init_options = {
        settings = {
            args = {}, -- customize args if needed
        },
    },
})

-- black python formatter 
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
    },
})

-- Pyright (python lsp)
lspconfig.pyright.setup({
    capabilities = capabilities,
})

local servers = require("mason-lspconfig").get_installed_servers()
for _, server in ipairs(servers) do
    require("lspconfig")[server].setup({
        capabilities = capabilities,
    })
end


