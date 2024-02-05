local popup = require("plenary.popup")

local notes_path = vim.fn.stdpath("data") .. "/notes";
local notepad_path = notes_path .. "/notepad.md"

-- Need to check if notepad exists for the current project
local function get_info()
    print("Getting info")
    print(notes_path)
    print(vim.api.nvim_buf_get_name(0))

    if vim.fn.isdirectory(notes_path) == 0 then
        print("Notes directory does not exist")
    else
        print("Notes directory exists")
    end

    if vim.fn.filereadable(notepad_path) == 0 then
        print("Notepad does not exist")
    else
        print("Notepad exists")
    end
end

local M = {}

function M.setup()
    get_info()
end


-- function create_notepad()
--     -- Setup default window
--     local height = 20
--     local width = 80
--     local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
--     local bufnr = vim.api.nvim_create_buf(false, false)
-- 
--     local win_id = popup.create(bufnr, {
--         title = "Notepad",
--         highlight = "MyNotepadWindow",
--         line = math.floor(((vim.o.lines - height) / 2) - 1),
--         col = math.floor((vim.o.columns - width) / 2),
--         minwidth = width,
--         minheight = height,
--         style = "minimal",
--         borderchars = borderchars,
--     })
-- 
--     setup_autocmds_and_keymaps(bufnr)
-- end
-- 
-- -- this should let us run our code on buffer save
-- function setup_autocmds_and_keymaps(bufnr)
--     local curr_file = vim.api.nvim_buf_get_name(0)
-- 
--     vim.api.nvim_create_autocmd({ "BufLeave", "BufWriteCmd" }, {
--         buffer = bufnr,
--         callback = function()
--             -- get_lines()
--         end,
--     })
-- end
-- 
-- function get_lines()
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--     for i in ipairs(lines) do
--         print(lines[i])
--     end
-- end
-- 
-- function write_lines()
-- 
-- end

return M
