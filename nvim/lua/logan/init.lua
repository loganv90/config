-- To see all startup messages from the config, ":messages"
-- To re-source the config, ":source {path to config or % from init.lua}"
-- To run some lua code visually select the code then do, ":source"
-- To see Mason installs, ":Mason"
-- To see Lazy installs, ":Lazy"
-- To see LSP status, ":LspInfo"
-- To see Treesitter info at cursor, ":Inspect"
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
-- To set and jump to marks: "m{mark}", "'{mark}", "`{mark}"
-- To open the link under the cursor in a browser: "gx"
-- To open the file path under the cursor: "gf", "<C-w>f", "<C-w>gf"
-- To view undo branches: ":undol", ":undolist"
-- To jump to an undo branch: ":undo {number}"
-- To move to item in quickfix list: ":cc{number}"
-- To see quickfix list history: ":chi", ":chistory"
-- To switch to quickfix list from history: ":{number}chi"
-- To get a list of recent buffers: ":ls", ":ls t"
-- To get a list of previous files: ":browse oldfiles", ":bro ol"
-- To get a list of all keymaps: ":map"
-- To search through command history: "q:"
-- To search through search history: "q/"
-- To list available commands: ":<C-d>", ":<C-space>"
-- To create and start editing a new file: ":e {filename}"
-- To execute the current file as bash script: ":!chmod +x %", ":!bash %:p"
-- To diff files and use changes: ":windo diffthis", ":bufdo diffoff", "dp", "do"

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

vim.keymap.set("n", "-", "<CMD>Explore<CR>", {})
vim.keymap.set("n", "+", "<CMD>tab split<CR>", {})





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
local fzf_lua_history_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'fzf-lua-history')
fzf_lua.setup({
    winopts = {
        border = 'none',
        backdrop = 100,
        fullscreen = true,
        preview = {
            border = 'none',
            wrap = true,
            vertical = 'up:50%',
            horizontal = 'right:50%',
            layout = 'flex',
        },
        on_create = function()
            vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
        end,
    },
    fzf_opts = {
        ['--layout'] = 'default',
        ['--history'] = fzf_lua_history_path,
    },
    keymap = {
        builtin = {
            true,
            ["<C-u>"] = "preview-half-page-up",
            ["<C-d>"] = "preview-half-page-down",
        },
        fzf = {
            true,
            ["ctrl-n"] = "down",
            ["ctrl-p"] = "up",
            ["ctrl-u"] = "preview-half-page-up",
            ["ctrl-d"] = "preview-half-page-down",
            ["shift-tab"] = "toggle-all",
            ["tab"] = "toggle",
        },
        -- To toggle fzf wrap: ctrl-/ or alt-/ or ctrl-_ or ctrl--
        -- To toggle help: F1
        -- To toggle fullscreen: F2
        -- To toggle preview wrap: F3
        -- To toggle preview: F4
    },
    previewers = {
        git_diff = {
            cmd_modified = "" ..
            "output=$(" ..
            "git diff --color --word-diff-regex='[[:space:]]|[^[:space:]]+' {file}" ..
            "); if [ -z \"$output\" ]; then output=$(" ..
            "git diff --color HEAD --word-diff-regex='[[:space:]]|[^[:space:]]+' {file}" ..
            "); fi; printf \"%s\\n\" \"$output\"",
        },
    },
    git = {
        status = {
            actions = {
                ["ctrl-x"] = false,
            },
        },
    },
})
local function fzf_lua_search_history()
    local lines = {}
    local seen_lines = {}
    for line in io.lines(fzf_lua_history_path) do
        if seen_lines[line] == nil then
            seen_lines[line] = true
            table.insert(lines, line)
        end
    end
    if #lines <= 0 then
        print("FZF-LUA: No search history found")
        return
    end

    local opts = {
        fzf_opts = {
            ['--tac'] = true,
            ['--no-sort'] = true,
        },
        actions = {
            ['default'] = function(selected)
                vim.fn.setreg('"', selected[1])
            end,
        },
    }

    fzf_lua.fzf_exec(lines, opts)
end
vim.keymap.set('n', '<leader>sh', fzf_lua_search_history, {})
vim.keymap.set('n', '<leader>sf', fzf_lua.files, {})
vim.keymap.set('n', '<leader>sg', fzf_lua.live_grep, {})
vim.keymap.set('n', '<leader>ss', function () fzf_lua.git_status({ fzf_opts = {['--layout'] = 'reverse'} }) end, {})
vim.keymap.set('n', '<leader>sd', function () fzf_lua.git_hunks({ fzf_opts = {['--layout'] = 'reverse', ['--delimiter'] = ':', ['--nth'] = '1..'} }) end, {})
vim.keymap.set('n', '<leader>scg', function () fzf_lua.live_grep({ cwd = vim.fn.stdpath('config') }) end, {})
vim.keymap.set('n', '<leader>spg', function () fzf_lua.live_grep({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') }) end, {})





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

local ts_utils = require("nvim-treesitter.ts_utils")

local function ts_get_first_moved_parent(node)
    local root = ts_utils.get_root_for_node(node)

    while true do
        local parent = node:parent()
        if not parent then
            break
        end

        local rs, cs, re, ce = node:range()
        local prs, pcs, pre, pce = parent:range()
        if not ((rs == prs and cs == pcs) or (re == pre and ce == pce)) or parent == root then
            return parent
        end

        node = parent
    end

    return node
end

local function ts_get_parent_at_position(node)
    local root = ts_utils.get_root_for_node(node)

    while true do
        local parent = node:parent()
        if not parent then
            break
        end

        local rs, cs, re, ce = node:range()
        local prs, pcs, pre, pce = parent:range()
        if not ((rs == prs and cs == pcs) or (re == pre and ce == pce)) or parent == root then
            break
        end

        node = parent
    end

    return node
end

local function ts_cursor_at_node_start(node)
    local rc, cc = vim.fn.line('.') - 1, vim.fn.col('.') - 1
    local r, c, _, _ = node:range()
    return rc == r and cc == c
end

local function ts_cursor_at_node_end(node)
    local rc, cc = vim.fn.line('.') - 1, vim.fn.col('.')
    local _, _, r, c = node:range()
    return rc == r and cc == c
end

local function ts_get_node_at_cursor()
    local jumped_forward = false
    while true do
        local captures = vim.treesitter.get_captures_at_cursor()
        if #captures > 0 then
            break
        end

        vim.cmd("normal! W")
        jumped_forward = true

        local current_row, current_col, last_row = vim.fn.line('.'), vim.fn.col('.'), vim.fn.line('$')
        local last_col = vim.fn.col({last_row, '$'})
        if current_row == last_row and current_col == last_col then
            break
        end
    end

    local node = ts_utils.get_node_at_cursor()
    if not node then
        print("TS: No node found at cursor")
        return nil, jumped_forward
    end

    return node, jumped_forward
end

local function ts_goto_parent()
    local node = ts_get_node_at_cursor()
    if not node then
        return
    end
    local parent = ts_get_parent_at_position(node)
    if not ts_cursor_at_node_start(parent) then
        ts_utils.goto_node(parent)
        return
    end
    parent = ts_get_first_moved_parent(parent)
    ts_utils.goto_node(parent)
end

local function ts_goto_end()
    local node = ts_get_node_at_cursor()
    if not node then
        return
    end
    local parent = ts_get_parent_at_position(node)
    if not ts_cursor_at_node_end(parent) then
        ts_utils.goto_node(parent, true)
        return
    end
    ts_utils.goto_node(parent:next_sibling() or parent, true)
end

local function ts_goto_next()
    local node, jumped_forward = ts_get_node_at_cursor()
    if not node then
        return
    end
    if jumped_forward then
        return
    end
    local parent = ts_get_parent_at_position(node)
    ts_utils.goto_node(parent:next_sibling() or parent)
end

local function ts_goto_prev()
    local node = ts_get_node_at_cursor()
    if not node then
        return
    end
    local parent = ts_get_parent_at_position(node)
    if not ts_cursor_at_node_start(parent) then
        ts_utils.goto_node(parent)
        return
    end
    ts_utils.goto_node(parent:prev_sibling() or parent)
end

vim.keymap.set("n", "<leader>tg", ts_goto_parent, {})
vim.keymap.set("n", "<leader>te", ts_goto_end, {})
vim.keymap.set("n", "<leader>tw", ts_goto_next, {})
vim.keymap.set("n", "<leader>tb", ts_goto_prev, {})
vim.keymap.set('n', '<leader>ts', function () fzf_lua.treesitter({ fzf_opts = {['--layout'] = 'reverse'} }) end, {})





require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set(
            'n',
            '[c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                else
                    gs.nav_hunk('prev')
                end
            end,
            { buffer = bufnr, }
        )

        vim.keymap.set(
            'n',
            ']c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                else
                    gs.nav_hunk('next')
                end
            end,
            { buffer = bufnr, }
        )

        vim.keymap.set('n', '<leader>gb', gs.blame, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>gs', ":Gitsigns stage_hunk<CR>", { buffer = bufnr })
        vim.keymap.set('n', '<leader>gr', ":Gitsigns reset_hunk<CR>", { buffer = bufnr })
    end,
})





local mason = require('mason')
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
        vim.keymap.set('n', '<leader>le', fzf_lua.lsp_workspace_diagnostics, { buffer = bufnr, remap = false })
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

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.config('gopls', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.config('pyright', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})
vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.config('clangd', {
    capabilities = capabilities,
    settings = {},
})

vim.lsp.enable('ts_ls')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

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

