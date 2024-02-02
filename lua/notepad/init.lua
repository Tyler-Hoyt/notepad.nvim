local popup = require("plenary.popup")



function create_notepad()
    -- Setup default window
    local height = 20
    local width = 80
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = vim.api.nvim_create_buf(false, false)

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

-- this should let us run our code on buffer save, at least I believe
function M.setup_autocmds_and_keymaps(bufnr)
    local curr_file = vim.api.nvim_buf_get_name(0)

    vim.api.nvim_create_autocmd({ "BufWriteCmd" }, {
        group = HarpoonGroup,
        buffer = bufnr,
        callback = function()
            require("harpoon").ui:save()
            vim.schedule(function()
                require("harpoon").logger:log("toggle by BufWriteCmd")
                require("harpoon").ui:toggle_quick_menu()
            end)
        end,
    })
end

function get_lines()
    vim.api.nvim_buf_get_lines(0, 0, -1, false)
end
