local path = require("plenary.path")
local popup = require("plenary.popup")

local dir_path = vim.fn.stdpath("data") .. "/notes"

-- Get the parent directory of the current working directory
local function get_parent_dir()
    local parent_dir = "/" .. vim.fs.basename(vim.fs.dirname(vim.fn.getcwd()))
    return parent_dir
end

-- Need to check if notepad exists for the current project
local function set_dir_path()
    local notepad_path = dir_path .. get_parent_dir() .. "_" ..  "notepad.md"

    if vim.fn.isdirectory(dir_path) == 0 then
        print("Notes directory does not exist")
        path:new(dir_path):mkdir()
    else
        print("Notes directory exists")
    end
if vim.fn.filereadable(notepad_path) == 0 then
        print("Notepad does not exist")
        path:new(notepad_path):touch()
    else
        print("Notepad exists")
    end
end



local M = {}

function M.setup()
    -- Sets up our notes directory and notepad file for the current project
    set_dir_path()
end


function M.create_notepad()
    -- Setup default window
    local height = 20
    local width = 80
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

    vim.api.nvim_buf_set_name(bufnr, dir_path .. get_parent_dir() .. "_" .. "notepad.md")
    vim.api.nvim_buf_call(bufnr, vim.cmd.edit)

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
