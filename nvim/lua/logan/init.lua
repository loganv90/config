-- To see all keymaps, ":h index"
-- To run command, ":'<,'>norm {command}"
-- To run command in matching lines, ":'<,'>g/{pattern}/norm {command}"
-- To replace, ":'<,'>s/{pattern}/{replacement}/g"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.scrolloff = 4
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 80

vim.opt.completeopt = 'menu,menuone,preview'

vim.opt.mouse = ''

vim.g.mapleader = ' '

vim.keymap.set('n', '-', ':Explore<CR>', {})
vim.keymap.set('n', '+', ':tabnew<CR>', {})





local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }) end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'folke/tokyonight.nvim' },
    { 'folke/neodev.nvim' },

    { 'nvim-neotest/nvim-nio' },

    { 'ibhagwan/fzf-lua' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    { 'nvim-treesitter/nvim-treesitter-context' },

    { 'lewis6991/gitsigns.nvim' },
    { 'tpope/vim-fugitive' },

    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    { 'lopi-py/luau-lsp.nvim' },

    { 'github/copilot.vim' },

    { 'mfussenegger/nvim-dap' },
    { 'leoluz/nvim-dap-go' },
    { 'rcarriga/nvim-dap-ui' },
})





require('neodev').setup()
require('tokyonight').setup({
    style = 'night',
})
vim.cmd('colorscheme tokyonight')





local fzf_lua = require('fzf-lua')
fzf_lua.setup({
    winopts = {
        width = 0.75,
        height = 0.95,
        row = 0.5,
        col = 1,
        fullscreen = true,
        backdrop = 100,
        preview = {
            vertical = 'down:50%',
            layout = 'vertical',
        },
    },
    keymap = {
        builtin = {
            false,
            ["<C-t>"] = "toggle-fullscreen",
            ["<C-u>"] = "preview-page-up",
            ["<C-d>"] = "preview-page-down",
        },
        fzf = {
            false,
            ["ctrl-u"] = "preview-page-up",
            ["ctrl-d"] = "preview-page-down",
        }
    },
})
vim.keymap.set('n', '<leader>sf', fzf_lua.files, {})
vim.keymap.set('n', '<leader>sg', fzf_lua.grep, {})
vim.keymap.set('n', '<leader>so', fzf_lua.oldfiles, {})
vim.keymap.set('n', '<leader>sb', fzf_lua.buffers, {})
vim.keymap.set('n', '<leader>st', fzf_lua.tabs, {})
vim.keymap.set('n', '<leader>sk', fzf_lua.keymaps, {})
vim.keymap.set('n', '<leader>sd', fzf_lua.diagnostics_workspace, {})
vim.keymap.set('n', '<leader>ss', fzf_lua.git_status, {})
vim.keymap.set('n', '<leader>sh', fzf_lua.search_history, {})
vim.keymap.set('n', '<leader>sc', fzf_lua.command_history, {})
vim.keymap.set('n', '<leader>sr', fzf_lua.resume, {})





-- When treesitter stops working, run the command :e! to refresh the buffer.
require'nvim-treesitter.configs'.setup({
    ensure_installed = {
        "c",
        "lua",
        "luau",
        "vim",
        "vimdoc",
        "query",
        "go",
        "javascript",
        "typescript",
        "rust",
        "html",
        "css",
        "tsx",
        "json",
        "python",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
    },
})
require'treesitter-context'.setup({
    enable = true,
    max_lines = 0,
    multiline_threshold = 1,
})





require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set(
            'n',
            '[c',
            function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end,
            { expr = true, buffer = bufnr, }
        )

        vim.keymap.set(
            'n',
            ']c',
            function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end,
            { expr = true, buffer = bufnr }
        )

        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { buffer = bufnr })
    end,
})
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', {})





local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local cmp = require('cmp')
local luasnip = require('luasnip')
local from_vscode = require('luasnip.loaders.from_vscode')

local on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>ld', fzf_lua.lsp_definitions, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>lr', fzf_lua.lsp_references, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>li', fzf_lua.lsp_implementations, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>ls', fzf_lua.lsp_document_symbols, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>lt', fzf_lua.lsp_typedefs, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = bufnr, remap = false })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, remap = false })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, { buffer = bufnr, remap = false })
end
local capabilities = cmp_nvim_lsp.default_capabilities()

mason.setup()
mason_lspconfig.setup {
    ensure_installed = {
        'ts_ls',
        'gopls',
        'pyright',
        'lua_ls',
        'luau_lsp',
    },
}
mason_lspconfig.setup_handlers {
    tsserver = function()
        lspconfig.tsserver.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
        }
    end,
    gopls = function()
        lspconfig.gopls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
        }
    end,
    pyright = function()
        lspconfig.pyright.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {},
        }
    end,
    lua_ls = function()
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        }
    end,
    luau_lsp = function()
        local luau_capabilities = vim.lsp.protocol.make_client_capabilities()
        luau_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        require('luau-lsp').setup({
            sourcemap = {
                enable = true,
                autogenerate = true,
                rojo_project_file = 'default.project.json',
            },
            platform = {
                type = 'roblox',
            },
            types = {
                roblox_security_level = 'PluginSecurity',
            },
            server = {
                filetypes = { 'luau' }, -- Not using luau-lsp for files with .lua extension.
                capabilities = luau_capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.keymap.set('n', '<leader>lg', ':LuauLsp regenerate_sourcemap<CR>', { buffer = bufnr, remap = false})
                end,
                settings = {
                    ['luau-lsp'] = {
                        completion = {
                            imports = {
                                enabled = true,
                            },
                        },
                    },
                },
            },
        })
    end,
}

from_vscode.lazy_load()
luasnip.config.setup()
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    completion = {
        completeopt = 'menu,menuone,preview',
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-t>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
})





local dap = require('dap')
local dap_go = require('dap-go')
local dapui = require('dapui')

vim.keymap.set('n', '<leader>dc', dap.continue, {})
vim.keymap.set('n', '<leader>ds', dap.step_over, {})
vim.keymap.set('n', '<leader>di', dap.step_into, {})
vim.keymap.set('n', '<leader>do', dap.step_out, {})
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, {})
vim.keymap.set('n', '<leader>de', dap.terminate, {})
vim.keymap.set('n', '<leader>dl', dap.run_last, {})
vim.keymap.set('n', '<leader>du', dap.up, {})
vim.keymap.set('n', '<leader>dd', dap.down, {})
vim.keymap.set('n', '<leader>dr',
    function()
        dapui.close( { layout = 2 } )
        dapui.close( { layout = 3 } )
        dapui.toggle( { layout = 1, reset = true } )
    end, {}
)
vim.keymap.set('n', '<leader>df',
    function()
        dapui.close( { layout = 1 } )
        dapui.close( { layout = 3 } )
        dapui.toggle( { layout = 2, reset = true } )
    end, {}
)
vim.keymap.set('n', '<leader>dv',
    function()
        dapui.close( { layout = 1 } )
        dapui.close( { layout = 2 } )
        dapui.toggle( { layout = 3, reset = true } )
    end, {}
)
vim.keymap.set('n', '<leader>dg', dap_go.debug_test, {})

dapui.setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "dc",
            pause = "ps",
            play = "pl",
            run_last = "rl",
            step_back = "sb",
            step_into = "si",
            step_out = "so",
            step_over = "st",
            terminate = "tm",
        },
    },
    element_mappings = {},
    expand_lines = false,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        },
    },
    force_buffers = true,
    icons = {
        collapsed = ">",
        current_frame = ">",
        expanded = "v",
    },
    layouts = {
        {
            elements = {
                {
                    id = "console",
                    size = 0.4,
                },
                {
                    id = "repl",
                    size = 0.6,
                },
            },
            position = "bottom",
            size = 0.4,
        },
        {
            elements = {
                {
                    id = "breakpoints",
                    size = 0.4,
                },
                {
                    id = "stacks",
                    size = 0.6,
                },
            },
            position = "bottom",
            size = 0.4,
        },
        {
            elements = {
                {
                    id = "watches",
                    size = 0.4,
                },
                {
                    id = "scopes",
                    size = 0.6,
                },
            },
            position = "bottom",
            size = 0.4,
        },
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
    },
    render = {
        indent = 1,
        max_value_lines = 100,
    }
})
dap_go.setup()

dap.configurations.python = {
    {
        type = 'pythonExecutable',
        request = 'launch',
        name = 'Launch',
        program = '${file}',
        pythonPath = '${workspaceFolder}/venv/bin/python',
    },
    {
        type = 'pythonServer',
        request = 'attach',
        name = 'Attach',
        host = '127.0.0.1',
        port = 5678,
    },
    {
        type = 'pythonExecutable',
        request = 'launch',
        name = 'Launch unittest',
        module = 'unittest',
        args = function() return { '${fileBasenameNoExtension}.' .. vim.fn.input('Test name: ') } end,
        pythonPath = '${workspaceFolder}/venv/bin/python',
    },
}

dap.adapters.pythonExecutable = {
    type = 'executable',
    command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python',
    args = { '-m', 'debugpy.adapter' },
    enrich_config = function(config, on_config)
        if not config.pythonPath and not config.python then
            config.pythonPath = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python'
        end
        on_config(config)
    end,
    options = {
        source_filetype = 'python',
    },
}

dap.adapters.pythonServer = {
    type = 'server',
    host = '127.0.0.1',
    port = 5678,
    enrich_config = function(config, on_config)
        if not config.pythonPath and not config.python then
            config.pythonPath = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python'
        end
        on_config(config)
    end,
    options = {
        source_filetype = 'python',
    },
}

