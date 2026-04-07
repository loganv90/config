-- To quit vim normally: ":q", ":qa", ":wq"
-- To quit vim with an error code to abort git commands: ":cq"
-- To view messages which includes print statements and debug statements: ":messages", ":mes"
-- To clear messages and to put messages content in the buffer: ":messages clear", ":mes clear", ":put =execute('messages')"
-- To re-source the config, ":source {path to config or % from init.lua}"
-- To run some lua code visually select the code then do, ":source"
-- To see installed plugins, save to update plugins, ":lua vim.pack.update()"
-- To remove installed plugin, ":lua vim.pack.del({'<plugin_name>'})"
-- To see LSP status, ":checkhealth vim.lsp"
-- To restart LSP, ":lsp restart"
-- To stop LSP, ":lsp stop"
-- To see Treesitter info at cursor, ":Inspect"
-- To see all keymaps, ":h index"
-- To run command, ":'<,'>norm {command}"
-- To run command in matching positions, ":'<,'>g/{pattern}/norm {command}"
-- To replace in matching positions, ":'<,'>s/{pattern}/{replacement}/g", ":'<,'>s{no|m}/{pattern}/{replacement}/g{i|I}"
-- To use magic and case sensitivity in search, ":\v{pattern}", ":\V{pattern}", ":\C{pattern}", ":\c{pattern}"
-- To see lua objects, ":lua =vim"
-- To run lua code, ":lua print('what')"
-- To run a lua file, ":luafile {path to lua file}"
-- To refresh the buffer, ":e!"
-- To move window to new tab, "<C-w>T"
-- To use terminal: ":term", "i", "<C-\><C-n>"
-- To use quickfix list: ":copen", ":cclose", ":cnext", ":cprev", "[q", "]q"
-- To use quickfix list history: ":chi", ":chistory", ":{number}chi"
-- To use location list: ":lopen", ":lclose", ":lnext", ":lprev", "[l", "]l"
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
-- To make all windows the same size: "<C-w>="
-- To set and reset the height of the current window: ":resize{number}", ":res{number}", ":res", "horizontal resize{number}", ":hor res{number}", ":hor res"
-- To set and reset the width of the current window: ":vertical resize{number}", ":vert res{number}", ":vert res"
-- To set args to many files and to navigate args: ":args {file name or path with wildcards}", "[a", "]a"
-- To set, unset, and view setting for fixing eol on save: ":set nofixeol", ":set fixeol", ":set nofixeol?", ":set fixeol?"
-- To select a treesitter node, and expand/shift selection by repeating the command ending: "van", "vin", "v[n", "v]n", "an", "in", "[n", "]n"
-- To update treesitter parsers: ":TSUpdate"

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





vim.pack.add({
    { src='https://github.com/ellisonleao/gruvbox.nvim' },
    { src='https://github.com/folke/snacks.nvim' },
    { src='https://github.com/nvim-treesitter/nvim-treesitter' },
    { src='https://github.com/folke/lazydev.nvim' },
    { src='https://github.com/neovim/nvim-lspconfig' },
    { src='https://github.com/lopi-py/luau-lsp.nvim' },
    { src='https://github.com/saghen/blink.cmp' },
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
        sources = {
            git_diff = {
                win = {
                    input = {
                        keys = {
                            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
                            ["<c-r>"] = false,
                        },
                    },
                },
            },
            git_status = {
                win = {
                    input = {
                        keys = {
                            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
                            ["<c-r>"] = false,
                        },
                    },
                },
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





local ts = require('nvim-treesitter')
ts.install({
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
})





local lazydev = require('lazydev')
lazydev.setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    }
})

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

vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('ts_ls')

vim.lsp.config('gopls', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('gopls')

vim.lsp.config('pyright', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('pyright')

-- install lua-language-server with mise
vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('lua_ls')

vim.lsp.config('rust_analyzer', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('clangd', {
    capabilities = capabilities,
    settings = {},
})
vim.lsp.enable('clangd')

-- install luau-lsp with rokit
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





-- https://github.com/{repo}/blame/{commit}/{path}
-- git@github.com:{repo}.git
---@param git_url string
---@param git_commit string
---@param repo_file_path string
---@param line_number integer|nil
---@return boolean|nil
local function git_open_github(git_url, git_commit, repo_file_path, line_number)
    local repo = string.match(git_url, "^git@github%.com:(.*)%.git$")
    if not repo then
        return
    end

    local line_suffix = line_number and string.format("#L%d", line_number) or ""
    local url = string.format("https://github.com/%s/blame/%s/%s%s", repo, git_commit, repo_file_path, line_suffix)
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
    local git_workspace_blame_obj = vim.system({"git", "blame", "-nf", "-L", line_range, "--", relative_file_path}):wait()
    if git_workspace_blame_obj.code ~= 0 then
        return
    end

    local git_commit_blame_obj = vim.system({"git", "blame", "-nf", commit, "--", relative_file_path}):wait()
    if git_commit_blame_obj.code ~= 0 then
        return
    end

    local git_workspace_blame = vim.trim(git_workspace_blame_obj.stdout)
    local git_commit_blame = vim.trim(git_commit_blame_obj.stdout)

    local original_commit, original_file, original_line = string.match(git_workspace_blame, "^(%S+)%s+(%S+)%s+(%S+)")
    if not original_commit or not original_file or not original_line then
        return
    end

    local s = "\n" .. git_commit_blame
    local pattern = "\n" .. original_commit .. "%s+" .. original_file .. "%s+" .. original_line .. "%s+%(.-%s+(%d+)%)"
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

---@return string|nil, string|nil, boolean
local function git_get_file()
    local file_path = vim.fn.expand('%:.')
    local git_path_obj = vim.system({"git", "ls-files", "--full-name", file_path}):wait()
    if git_path_obj.code ~= 0 then
        return nil, nil, false
    end

    local git_path = vim.trim(git_path_obj.stdout)

    local f = io.open(file_path, "r")
    if f == nil then
        return file_path, git_path, false
    end
    io.close(f)
    return file_path, git_path, true
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

    local relative_file_path, repo_file_path, is_file = git_get_file()
    if not relative_file_path or not repo_file_path then
        print("Git: Unable to get file path")
        return
    end

    local line_number = nil
    if is_file then
        line_number = git_get_line(relative_file_path, git_commit)
        if not line_number then
            print("Git: Unable to get line number")
        end
    end

    local github = git_open_github(git_url, git_commit, repo_file_path, line_number)
    if github then
        return
    end
end

vim.keymap.set('n', '<leader>g', git_open_provider, {})

