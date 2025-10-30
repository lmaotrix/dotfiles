-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --use 'Shatur/neovim-ayu'
    use "scottmckendry/cyberdream.nvim"
    use "nyoom-engineering/oxocarbon.nvim"
    use "navarasu/onedark.nvim"

    use ( "nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})

    --use {
    --    'nvim-lualine/lualine.nvim',
        --requires = { 'nvim-tree/nvim-web-devicons', opt = true,
    --    requires = {"echasnovski/mini.icons" }
    --}
    use {
        "echasnovski/mini.icons",
        config = function ()
            require("mini.icons").setup()
        end
    }
    use 'nvim-tree/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    --use 'romgrk/barbar.nvim'
    
    use {
        "folke/snacks.nvim",
        requires = { 'nvim-mini/mini.icons' },
        config = function ()
            require("trixvim.init")
        end
    }
    
    -- bufferline
    use { "akinsho/bufferline.nvim", requires = "kyazdani/nvim-web-devicons" }
    
    -- Virt-column
    use { "lukas-reineke/virt-column.nvim" }

    -- lualine
    use { "nvim-lualine/lualine.nvim", requires = { "nvim-mini/mini.icons" } }

    -- dropbar
    use {
        "Bekaboo/dropbar.nvim",
        requires = { {"nvim-telescope/telescope-fzf-native.nvim", run = "make"} }
    }


    use 'tribela/transparent.nvim'

    use 'nvim-lua/plenary.nvim'
    use 'ThePrimeagen/harpoon'

    -- LSP + Mason
    use 'mason-org/mason.nvim'
    use 'neovim/nvim-lspconfig'
    use 'mason-org/mason-lspconfig.nvim'

    -- Autocompletion
    use "hrsh7th/nvim-cmp"          -- Main completion engine

    use "hrsh7th/cmp-nvim-lsp"      -- LSP completions
    use "hrsh7th/cmp-buffer"        -- Buffer completions
    use "hrsh7th/cmp-path"          -- Path completions
    use "hrsh7th/cmp-cmdline"       -- Command-line completions
    use "saadparwaiz1/cmp_luasnip"  -- Snippet completions  
    use {
        "windwp/nvim-autopairs",    -- Bracket Autocompletion
        config = function ()
            require("nvim-autopairs").setup {}
        end
    }
    use "nvimtools/none-ls.nvim" -- python formatter

    -- Snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    use {
        "folke/noice.nvim",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback

            "rcarriga/nvim-notify",

        }
    }

    use "MunifTanjim/nui.nvim"

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use "folke/which-key.nvim" 


end)
