local packer = require('packer')
packer.startup({
    function(use)
        -- Packer 可以管理自己本身
        use('wbthomason/packer.nvim')
        --------------------- colorschemes --------------------
        -- tokyonight
        use('folke/tokyonight.nvim')
        -------------------------- plugins -------------------------------------------
        -- nvim-tree
        use({ 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' })
        -- bufferline
        use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' } })
        -- lualine
        use({ 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } })
        use('arkav/lualine-lsp-progress')
        -- telescope
        use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })
        -- telescope extensions
        use('LinArcX/telescope-env.nvim')
        -- dashboard-nvim
        use('glepnir/dashboard-nvim')
        -- project
        use('ahmedkhalf/project.nvim')
        -- treesitter
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
        use('JoosepAlviste/nvim-ts-context-commentstring')
        -- indent-blankline
        use('lukas-reineke/indent-blankline.nvim')
        -- autopairs
        use('windwp/nvim-autopairs')
        -- Easily comment stuff
        use('numToStr/Comment.nvim')
        -- Git
        use('lewis6991/gitsigns.nvim')
        -- hop.nvim
        use({ 'phaazon/hop.nvim', branch = 'v1' })
        -- glow.nvim for markdown
        use({ 'ellisonleao/glow.nvim' })

        --------------------- LSP --------------------
        -- lspconfig
        use({ 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' })
        -- 补全引擎
        use('hrsh7th/nvim-cmp')
        -- snippet 引擎
        use('hrsh7th/vim-vsnip')
        -- 补全源
        use('hrsh7th/cmp-vsnip')
        use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
        use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
        use('hrsh7th/cmp-path') -- { name = 'path' }
        use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
        -- 常见编程语言代码段
        use('rafamadriz/friendly-snippets')
        -- ui
        use('onsails/lspkind-nvim')
        use('tami5/lspsaga.nvim')
        -- 代码格式化
        -- use("mhartington/formatter.nvim")
        use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
    end,
    config = {
        -- 并发数限制
        max_jobs = 16,
        -- 自定义源
        git = {
            -- default_url_format = "https://hub.fastgit.xyz/%s",
            -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
            -- default_url_format = "https://gitcode.net/mirrors/%s",
            -- default_url_format = "https://gitclone.com/github.com/%s",
        },
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})

-- 每次保存 plugins.lua 自动安装插件
pcall(
    vim.cmd,
    [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
