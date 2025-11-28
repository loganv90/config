-- To see all startup messages from the config, ":messages"
-- To re-source the config, ":source {path to config or % from init.lua}"
-- To run some lua code visually select the code then do, ":source"
-- To see Mason installs, ":Mason"
-- To see Lazy installs, ":Lazy"
-- To see LSP status, ":LspInfo"
-- To see Treesitter info at cursor, ":Inspect"
-- To see all keymaps, ":h index"
-- To run command, ":'<,'>norm {command}"
-- To run command in matching positions, ":'<,'>g/{pattern}/norm {command}"
-- To replace in matching positions, ":'<,'>s/{pattern}/{replacement}/g", ":'<,'>s{no|m}/{pattern}/{replacement}/g{i|I}"
-- To use magic and case sensitivity in search, ":\v{pattern}", ":\V{pattern}", ":\C{pattern}", ":\c{pattern}"
-- To see lua objects, ":lua =vim"
-- To run lua code, ":lua print('what')"
-- To refresh the buffer, ":e!"
-- To move window to new tab, "<C-w>T"
-- To use terminal: ":term", "i", "<C-\><C-n>"
-- To use quickfix list: ":copen", ":cclose", ":cnext", ":cprev"
-- To use quickfix list history: ":chi", ":chistory", ":{number}chi"
-- To use location list: ":lopen", ":lclose", ":lnext", ":lprev"
-- To use quickfix list history: ":lhi", ":lhistory", ":{number}lhi"
-- To use tag stack: "<C-]>", "<C-t>"
-- To reset "C-u" and "C-d" scrolling distance, ":set scroll=0"
-- To remove search highlight: ":nohl", "<C-l>"
-- To move between words: "w", "W", "b", "B", "e", "E", "ge", "gE"
-- To edit command-line command in command-line window: "<C-f>"
-- To return from command-line window with command: "<C-c>"
-- To search through command history: "q:"
-- To search through search history: "q/"
-- To edit macros, paste from and yank to registers: ""{register}p", ""{register}y"
-- To paste from registers in insert mode, and use expression register: "<C-r>{register}", "<C-r>="
-- To record macros, and clear recorded macros: "q{register}{recording}q", "q{register}q"
-- To set and jump to marks: "m{mark}", "'{mark}", "`{mark}"
-- To open the link under the cursor in a browser: "gx"
-- To open the file path under the cursor: "gf", "<C-w>f", "<C-w>gf"
-- To view undo branches: ":undol", ":undolist"
-- To jump to an undo branch: ":undo {number}"
-- To get a list of recent buffers: ":ls", ":ls t"
-- To get a list of previous files: ":browse oldfiles", ":bro ol"
-- To get a list of all keymaps: ":map"
-- To list available commands: ":<C-d>", ":<C-space>"
-- To create and start editing a new file: ":e {filename}"
-- To execute the current file as bash script: ":!chmod +x %", ":!bash %:p"
-- To diff files and use changes: ":windo diffthis", ":bufdo diffoff", "dp", "do"
-- To sort lines of text: ":'<,'>sort"

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

    {
        'folke/snacks.nvim',
        priority = 1000,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },

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





-- TODO when doing git_status, focus on the list item corresponding to the current file
-- TODO when doing git_diff, focus on the list item corresponding to the closest hunk to the cursor line
-- TODO when doing git_diff, add keymap to filter out staged hunks
-- TODO add visual mode binds for files and grep
local snacks = require('snacks')
---@param file string
local snacks_git_diff_hunks = function (file)
    snacks.picker.git_diff({
        pattern = file,
    })
end
local snacks_git_diff_files = function ()
    snacks.picker.git_status({
        win = {
            input = {
                keys = {
                    ["<S-Tab>"] = { "open_git_diff_hunks", mode = { "n", "i" } }
                }
            }
        }
    })
end
snacks.setup({
    picker = {
        prompt = "> ",
        win = {
            input = {
                keys = {
                    ["<c-n>"] = { "history_forward", mode = { "i", "n" } },
                    ["<c-p>"] = { "history_back", mode = { "i", "n" } },
                    ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                    ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                    ["<c-b>"] = { "list_scroll_up", mode = { "i", "n" } },
                    ["<c-f>"] = { "list_scroll_down", mode = { "i", "n" } },
                },
            },
        },
        layout = {
            fullscreen = true,
            layout = {
                box = "horizontal",
                {
                    box = "vertical",
                    border = "right",
                    { win = "input", border = "none", height = 1 },
                    { win = "list", border = "none" },
                },
                { win = "preview", border = "none", width = 0.5 },
            },
        },
        icons = {
            files = {
                enabled = false,
            },
            diagnostics = {
                Error = "E ",
                Warn  = "W ",
                Hint  = "H ",
                Info  = "I ",
            },
        },
        previewers = {
            diff = {
                style = "syntax",
                win = {
                    input = {
                        keys = {
                            ["<c-n>"] = { function() print('this is my message') end, mode = { "i", "n" } },
                        },
                    },
                },
            },
        },
        actions = {
            open_git_diff_hunks = function(picker)
                local item = picker:current()
                if not item then
                    return
                end

                local file = item.file
                if not file then
                    return
                end

                picker:close()
                snacks_git_diff_hunks(file)
            end,
        },
    },
    -- To toggle live grep: ctrl-g
    -- To toggle preview: alt-p
    -- To toggle help: ?
    -- To open in new tab: ctrl-t
    -- To open in split: ctrl-s
    -- To open in vsplit: ctrl-v
    -- To open in quickfix: ctrl-q
})
vim.keymap.set('n', '<leader>sf', function () snacks.picker.files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>sg', function () snacks.picker.grep() end, {})
vim.keymap.set('n', '<leader>ss', function () snacks_git_diff_files() end, {})
vim.keymap.set('n', '<leader>sd', function () snacks_git_diff_hunks(vim.fn.expand('%:.')) end, {})
vim.keymap.set('n', '<leader>scg', function () snacks.picker.grep({ cwd = vim.fn.stdpath('config') }) end, {})
vim.keymap.set('n', '<leader>spg', function () snacks.picker.grep({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') }) end, {})





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

---@type TSNode|nil
local ts_current_node = nil
---@type integer|nil
local ts_current_buffer = nil
---@type integer
local ts_ns_id = vim.api.nvim_create_namespace("ts_current_node_highlights")

local function ts_util_clear_node()
    if ts_current_buffer then
        vim.api.nvim_buf_clear_namespace(ts_current_buffer, ts_ns_id, 0, -1)
    end
end

---@param node TSNode
---@param buffer integer
---@param ending boolean
local function ts_util_set_node(node, buffer, ending)
    ts_util_clear_node()
    ts_current_node, ts_current_buffer = node, buffer
    local start_row, start_col, end_row, end_col = node:range()
    vim.api.nvim_buf_set_extmark(
        buffer,
        ts_ns_id,
        start_row,
        start_col,
        {
            end_line = end_row,
            end_col = end_col,
            hl_group = "Visual",
        }
    )
    vim.api.nvim_win_set_buf(0, buffer)
    vim.api.nvim_win_set_cursor(0, ending and { end_row + 1, end_col - 1 } or { start_row + 1, start_col })
end

---@return TSNode|nil, integer|nil
local function ts_util_get_node_at_cursor()
    while true do
        local captures = vim.treesitter.get_captures_at_cursor()
        if #captures > 0 then
            break
        end
        vim.cmd("normal! W")
        local current_row, current_col, last_row = vim.fn.line('.'), vim.fn.col('.'), vim.fn.line('$')
        local last_col = vim.fn.col({last_row, '$'})
        if current_row == last_row and current_col == last_col then
            break
        end
    end
    local node = ts_utils.get_node_at_cursor()
    if not node then
        return nil, nil
    end
    local bufnr = vim.api.nvim_get_current_buf()
    return node, bufnr
end

local function ts_node_set()
    local node, buffer = ts_util_get_node_at_cursor()
    if not node or not buffer then
        print("TS: No node found at cursor")
        return
    end
    ts_util_set_node(node, buffer, false)
end

local function ts_node_clear()
    ts_util_clear_node()
end

local function ts_node_next()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    local next_node = ts_current_node:next_sibling()
    if not next_node then
        print("TS: No next sibling node")
        return
    end
    ts_util_set_node(next_node, ts_current_buffer, false)
end

local function ts_node_prev()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    local prev_node = ts_current_node:prev_sibling()
    if not prev_node then
        print("TS: No previous sibling node")
        return
    end
    ts_util_set_node(prev_node, ts_current_buffer, false)
end

local function ts_node_parent()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    local parent_node = ts_current_node:parent()
    if not parent_node then
        print("TS: No parent node")
        return
    end
    ts_util_set_node(parent_node, ts_current_buffer, false)
end

local function ts_node_child()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    local child_node = ts_current_node:child(0)
    if not child_node then
        print("TS: No child node")
        return
    end
    ts_util_set_node(child_node, ts_current_buffer, false)
end

local function ts_node_start()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    ts_util_set_node(ts_current_node, ts_current_buffer, false)
end

local function ts_node_end()
    if not ts_current_node or not ts_current_buffer then
        print("TS: No current node set")
        return
    end
    ts_util_set_node(ts_current_node, ts_current_buffer, true)
end

---@param fun function
local function ts_jump_repeat(fun)
    local count = vim.v.count1
    vim.cmd("normal! m'")
    for _ = 1, count do
        fun()
    end
end

vim.keymap.set("n", "<leader>tt", function () ts_node_set() end, {})
vim.keymap.set("n", "<leader>tc", function () ts_node_clear() end, {})
vim.keymap.set("n", "<leader>tn", function () ts_jump_repeat(ts_node_next) end, {})
vim.keymap.set("n", "<leader>tp", function () ts_jump_repeat(ts_node_prev) end, {})
vim.keymap.set("n", "<leader>to", function () ts_jump_repeat(ts_node_parent) end, {})
vim.keymap.set("n", "<leader>ti", function () ts_jump_repeat(ts_node_child) end, {})
vim.keymap.set("n", "<leader>ta", function () ts_jump_repeat(ts_node_start) end, {})
vim.keymap.set("n", "<leader>te", function () ts_jump_repeat(ts_node_end) end, {})





local mason = require('mason')
local luau_lsp = require('luau-lsp')
local blink_cmp = require('blink.cmp')

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        vim.keymap.set('n', '<leader>lr', function () snacks.picker.lsp_references() end, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>le', function () snacks.picker.diagnostics() end, { buffer = bufnr, remap = false })
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

