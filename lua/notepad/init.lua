local path = require("plenary.path")
local popup = require("plenary.popup")

local dir_path = vim.fn.stdpath("data") .. "/notes"

-- Get the parent directory of the current working directory
local function get_parent_dir(filetype)
    local base_dir = vim.fs.basename(vim.fn.getcwd())
    local parent_base_dir = vim.fs.basename(vim.fs.dirname(vim.fn.getcwd()))
    return "/" .. base_dir .. "_" .. parent_base_dir .. filetype
end

-- Need to check if notepad exists for the current project
local function set_dir_path(filetype)
    local notepad_path = dir_path .. get_parent_dir(filetype)

    if vim.fn.isdirectory(dir_path) == 0 then
        path:new(dir_path):mkdir()
    end

    if vim.fn.filereadable(notepad_path) == 0 then
        path:new(notepad_path):touch()
    end
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local M = {}

function M:setup(opts)
    local filetypes = {".md", ".txt", ".norg"}
    opts = opts or {}

    -- Set filetype to .md if not specified
    if has_value(filetypes, opts.filetype) == false then
        error("Notepad: Filetype must be .md or .txt or .norg. Defaulting to .md.")
        opts.filetype = ".md"
        return
    else
        opts.filetype = opts.filetype
    end

    self.filetype = opts.filetype

    -- Sets up our notes directory and notepad file for the current project
    set_dir_path(opts.filetype)
    vim.api.nvim_set_keymap("n", "<leader>nn", ":lua require('notepad').open_notepad()<CR>", { noremap = true, silent = true })
end

function M:open_notepad()
    -- Need to check if buffer exists then open that buffer instead
    local notepad_path = dir_path .. get_parent_dir(self.filetype)

    -- Setup default window
    local height = 20
    local width = 80
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    vim.api.nvim_buf_set_name(bufnr, notepad_path)
    vim.api.nvim_buf_call(bufnr, vim.cmd.edit)
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")

    local win_id = popup.create(bufnr, {
        title = "Notepad",
        highlight = "MyNotepadWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        style = "minimal",
        borderchars = borderchars,
    })
end

return M
