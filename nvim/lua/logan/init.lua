-- To see all startup messages from the config, ":messages"
-- To re-source the config, ":source {path to config or % from init.lua}"
-- To run some lua code visually select the code then do, ":source"
-- To see Mason installs, ":Mason"
-- To see Lazy installs, ":Lazy"
-- To see LSP status, ":LspInfo"
-- To see all keymaps, ":h index"
-- To run command, ":'<,'>norm {command}"
-- To run command in matching lines, ":'<,'>g/{pattern}/norm {command}"
-- To replace, ":'<,'>s/{pattern}/{replacement}/g"
-- To see lua objects, ":lua =vim"
-- To run lua code, ":lua print('what')"
-- To refresh the buffer, ":e!"
-- To move window to new tab, "<C-w>T"
-- To use terminal: ":term", "i", "<C-\><C-n>"
-- To use quickfix: ":copen", ":cclose", ":cnext", ":cprev"
-- To use tag stack: "<C-]>", "<C-t>"
-- To reset "C-u" and "C-d" scrolling distance, ":set scroll=0"
-- To remove search highlight: ":nohl", "<C-l>"
-- To move between words: "w", "W", "b", "B", "e", "E", "ge", "gE"
-- To edit command-line command in command-line window: "<C-f>"
-- To return from command-line window with command: "<C-c>"
-- To edit macros, paste from and yank to registers: ""{register}p", ""{register}y"
-- To open the link under the cursor in a browser: "gx"

-- TODO try nvim oil
-- TODO try undo tree
-- TODO add treesitter movement binds

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = {
    tab = '> ',
    trail = '-',
    nbsp = '+',
}

vim.opt.cursorline = true
vim.opt.guicursor = "n-v-c-ci-sm:block,i-ve:ver25,r-cr-o:hor20"

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
vim.g.maplocalleader = '\\'

vim.keymap.set('n', '-', ':Explore<CR>', {})
vim.keymap.set('n', '+', ':tab split<CR>', {})





local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            }
        }
    },
    { 'nvim-neotest/nvim-nio' },
    { "ellisonleao/gruvbox.nvim" },

    { 'ibhagwan/fzf-lua' },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    { 'nvim-treesitter/nvim-treesitter-context' },

    { 'lewis6991/gitsigns.nvim' },

    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'lopi-py/luau-lsp.nvim' },

    { 'saghen/blink.cmp' },
    { 'rafamadriz/friendly-snippets' },

    { 'github/copilot.vim' },

    { 'mfussenegger/nvim-dap' },
    { 'leoluz/nvim-dap-go' },
    { 'rcarriga/nvim-dap-ui' },
})





local gruvbox = require("gruvbox")
gruvbox.setup({
    overrides = {
        SignColumn = { bg = gruvbox.palette.dark0 },
        GruvboxRedSign = { bg = gruvbox.palette.dark0 },
        GruvboxGreenSign = { bg = gruvbox.palette.dark0 },
        GruvboxYellowSign = { bg = gruvbox.palette.dark0 },
        GruvboxBlueSign = { bg = gruvbox.palette.dark0 },
        GruvboxPurpleSign = { bg = gruvbox.palette.dark0 },
        GruvboxAquaSign = { bg = gruvbox.palette.dark0 },
        GruvboxOrangeSign = { bg = gruvbox.palette.dark0 },
    },
})
vim.cmd("colorscheme gruvbox")





local fzf_lua = require('fzf-lua')
fzf_lua.setup({
    winopts = {
        width = 0.5,
        height = 1,
        row = 0.5,
        col = 1,
        fullscreen = true,
        backdrop = 100,
        border = 'none',
        preview = {
            vertical = 'up:50%',
            horizontal = 'right:50%',
            layout = 'flex',
        },
    },
    fzf_opts = {
        ['--layout'] = 'default',
        ['--history'] = vim.fs.joinpath(vim.fn.stdpath('data'), 'fzf-lua-history'),
    },
    keymap = {
        builtin = {
            true,
            ["<C-y>"] = "preview-up",
            ["<C-e>"] = "preview-down",
            ["<C-u>"] = "preview-half-page-up",
            ["<C-d>"] = "preview-half-page-down",
        },
        fzf = {
            true,
            ["ctrl-y"] = "preview-up",
            ["ctrl-e"] = "preview-down",
            ["ctrl-u"] = "preview-half-page-up",
            ["ctrl-d"] = "preview-half-page-down",

            ["ctrl-a"] = "toggle-all",
            ["tab"] = "toggle",
        }
    },
})
vim.keymap.set('n', '<leader>sf', fzf_lua.files, {})
vim.keymap.set('n', '<leader>sg', fzf_lua.live_grep, {})
vim.keymap.set('v', '<leader>sg', fzf_lua.grep_visual, {})
vim.keymap.set('n', '<leader>so', fzf_lua.oldfiles, {})
vim.keymap.set('n', '<leader>sb', fzf_lua.buffers, {})
vim.keymap.set('n', '<leader>st', fzf_lua.tabs, {})
vim.keymap.set('n', '<leader>sk', fzf_lua.keymaps, {})
vim.keymap.set('n', '<leader>sd', fzf_lua.diagnostics_workspace, {})
vim.keymap.set('n', '<leader>ss', fzf_lua.git_status, {})
vim.keymap.set('n', '<leader>st', fzf_lua.search_history, {})
vim.keymap.set('n', '<leader>sc', fzf_lua.command_history, {})
vim.keymap.set('n', '<leader>sr', fzf_lua.resume, {})
vim.keymap.set('n', '<leader>sh', fzf_lua.helptags, {})
vim.keymap.set('n', '<leader>sec', function () fzf_lua.live_grep({ cwd=vim.fn.stdpath('config') }) end, {})
vim.keymap.set('n', '<leader>sep', function () fzf_lua.live_grep({ cwd=vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') }) end, {})





require'nvim-treesitter.configs'.setup({
    ensure_installed = {
        "c",
        "cpp",
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
    max_lines = '50%',
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

        vim.keymap.set('n', '<leader>gb', gs.blame, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { buffer = bufnr })
    end,
})





local mason = require('mason')
local lspconfig = require('lspconfig')
local luau_lsp = require('luau-lsp')
local blink_cmp = require('blink.cmp')

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        vim.keymap.set('n', '<leader>ld', fzf_lua.lsp_definitions, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lr', fzf_lua.lsp_references, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>li', fzf_lua.lsp_implementations, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>ls', fzf_lua.lsp_document_symbols, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lt', fzf_lua.lsp_typedefs, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lg', ':LuauLsp regenerate_sourcemap<CR>', { buffer = bufnr, remap = false})
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, { buffer = bufnr, remap = false })
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
})

local capabilities = blink_cmp.get_lsp_capabilities()

mason.setup()

lspconfig.ts_ls.setup({
    capabilities = capabilities,
    settings = {},
})
lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {},
})
lspconfig.pyright.setup({
    capabilities = capabilities,
    settings = {},
})
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {},
})
lspconfig.clangd.setup({
    capabilities = capabilities,
    settings = {},
})
luau_lsp.config({
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    settings = {
        ['luau-lsp'] = {
            completion = {
                imports = {
                    enabled = true,
                },
            },
        },
    },
})

blink_cmp.setup({
    keymap = {
        preset = 'default'
    },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 0,
        },
        menu = {
            draw = {
                columns = { { "label", "label_description", gap = 1 }, { "kind" } },
            },
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
        implementation = "lua",
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

