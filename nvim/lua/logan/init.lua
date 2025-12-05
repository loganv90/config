-- To quit vim normally: ":q", ":qa", ":wq"
-- To quit vim with an error code to abort git commands: ":cq"
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





local snacks = require('snacks')
---@param relative_file_path string
local snacks_git_status = function (relative_file_path)
    snacks.picker.git_status({
        on_show = function(picker)
            local items = picker:items()
            for _, item in ipairs(items) do
                if item.file == relative_file_path then
                    local row = picker.list:idx2row(item.idx)
                    picker.list:view(row)
                    return
                end
            end
        end,
    })
end
---@param relative_file_path string
---@param line_number integer
local snacks_git_diff = function (relative_file_path, line_number)
    snacks.picker.git_diff({
        on_show = function(picker)
            ---@type snacks.picker.Item|nil
            local closest_item = nil
            ---@type number|nil
            local closest_distance = nil

            local items = picker:items()
            for _, item in ipairs(items) do
                if item.file == relative_file_path then
                    local item_line_number = item.pos[1]
                    local distance = math.abs(line_number - item_line_number)

                    if not closest_distance or (distance < closest_distance) then
                        closest_item = item
                        closest_distance = distance
                    end
                end
            end

            if closest_item then
                local row = picker.list:idx2row(closest_item.idx)
                picker.list:view(row)
            end
        end,
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
            },
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
vim.keymap.set('n', '<leader>ss', function () snacks_git_status(vim.fn.expand('%:.')) end, {})
vim.keymap.set('n', '<leader>sd', function () snacks_git_diff(vim.fn.expand('%:.'), vim.fn.line('.')) end, {})
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

local function ts_node_set()
    local node, buffer = ts_utils.get_node_at_cursor(), vim.api.nvim_get_current_buf()
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
---@param opts table?
local function ts_jump_repeat(fun, opts)
    local count
    if opts and opts.no_count then
        count = 1
    else
        count = vim.v.count1
    end
    if opts and opts.no_jump then
        -- do nothing
    else
        vim.cmd("normal! m'")
    end
    for _ = 1, count do
        fun()
    end
end

vim.keymap.set("n", "<leader>tt", function () ts_jump_repeat(ts_node_set, { no_count = true }) end, {})
vim.keymap.set("n", "<leader>tc", function () ts_jump_repeat(ts_node_clear, { no_jump = true }) end, {})
vim.keymap.set("n", "<leader>tn", function () ts_jump_repeat(ts_node_next) end, {})
vim.keymap.set("n", "<leader>tp", function () ts_jump_repeat(ts_node_prev) end, {})
vim.keymap.set("n", "<leader>to", function () ts_jump_repeat(ts_node_parent) end, {})
vim.keymap.set("n", "<leader>ti", function () ts_jump_repeat(ts_node_child) end, {})
vim.keymap.set("n", "<leader>ta", function () ts_jump_repeat(ts_node_start, { no_count = true }) end, {})
vim.keymap.set("n", "<leader>te", function () ts_jump_repeat(ts_node_end, { no_count = true }) end, {})





local mason = require('mason')
local luau_lsp = require('luau-lsp')
local blink_cmp = require('blink.cmp')

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        vim.keymap.set('n', '<leader>lr', function () snacks.picker.lsp_references() end, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>le', function () snacks.picker.diagnostics() end, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, { buffer = bufnr, remap = false })
        vim.keymap.set('n', '<leader>lg', ':LuauLsp regenerate_sourcemap<CR>', { buffer = bufnr, remap = false})
    end,
    -- To show hover: K
    -- To show signature help: ctrl-s
    -- To do code action: gra
    -- To do rename: grn
    -- To open type definition: grt
    -- To open implementation: gri
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





-- https://github.com/{repo}/blob/{commit}/{path}
-- git@github.com:{repo}.git
---@param git_url string
---@param git_commit string
---@param relative_file_path string
---@param line_number integer|nil
---@return boolean|nil
local function git_open_github(git_url, git_commit, relative_file_path, line_number)
    local repo = string.match(git_url, "^git@github%.com:(.*)%.git$")
    if not repo then
        return
    end

    local line_suffix = line_number and string.format("#L%d", line_number) or ""
    local url = string.format("https://github.com/%s/blob/%s/%s%s", repo, git_commit, relative_file_path, line_suffix)
    local open_obj = vim.system({"open", url}):wait()
    if open_obj.code ~= 0 then
        return
    end

    return true
end

---@param relative_file_path string
---@param commit string
---@return integer|nil
local function git_get_line(relative_file_path, commit)
    local line_number = vim.fn.line('.')
    local line_range = string.format("%d,%d", line_number, line_number)
    local git_workspace_blame_obj = vim.system({"git", "blame", "-n", "-L", line_range, "--", relative_file_path}):wait()
    if git_workspace_blame_obj.code ~= 0 then
        return
    end

    local git_commit_blame_obj = vim.system({"git", "blame", "-n", commit, "--", relative_file_path}):wait()
    if git_commit_blame_obj.code ~= 0 then
        return
    end

    local git_workspace_blame = vim.trim(git_workspace_blame_obj.stdout)
    local git_commit_blame = vim.trim(git_commit_blame_obj.stdout)

    local original_commit_and_line = string.match(git_workspace_blame, "^(%w+%s+%d+)%s+")
    if not original_commit_and_line then
        return
    end

    local s = "\n" .. git_commit_blame
    local pattern = "\n" .. original_commit_and_line .. "%s+%([%s%w%-%+:]+%s+(%d+)%)%s+"
    local current_line = string.match(s, pattern)
    if not current_line then
        return
    end

    return tonumber(current_line)
end

---@return string|nil
local function git_get_url()
    local git_url_obj = vim.system({"git", "remote", "get-url", "origin"}):wait()
    if git_url_obj.code ~= 0 then
        return
    end
    return vim.trim(git_url_obj.stdout)
end

---@return string|nil
local function git_get_commit()
    local git_log_obj = vim.system({"git", "log", "--pretty=format:%H"}):wait()
    if git_log_obj.code ~= 0 then
        return
    end

    local git_log = vim.trim(git_log_obj.stdout)

    local commit = nil
    for hash in string.gmatch(git_log, "[^\r\n]+") do
        local git_branch_obj = vim.system({"git", "branch", "-r", "--contains", hash}):wait()
        if git_branch_obj.code == 0 then
            local git_branch = vim.trim(git_branch_obj.stdout)
            if #git_branch > 0 then
                commit = hash
                break
            end
        end
    end

    return commit
end

---@return string, boolean
local function git_get_file()
    local file_path = vim.fn.expand('%:.')
    local f = io.open(file_path, "r")
    if f == nil then
        return file_path, false
    end
    io.close(f)
    return file_path, true
end

local function git_open_provider()
    local git_url = git_get_url()
    if not git_url then
        print("Git: Unable to get remote URL")
        return
    end

    local git_commit = git_get_commit()
    if not git_commit then
        print("Git: Unable to get commit hash")
        return
    end

    local relative_file_path, is_file = git_get_file()
    local line_number = nil
    if is_file then
        line_number = git_get_line(relative_file_path, git_commit)
        if not line_number then
            print("Git: Unable to get line number")
        end
    end

    local github = git_open_github(git_url, git_commit, relative_file_path, line_number)
    if github then
        return
    end
end

vim.keymap.set('n', '<leader>g', git_open_provider, {})

