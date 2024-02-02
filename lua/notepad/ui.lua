local popup = require("plenary.popup")

function ShowNotepad()
    local height = 10
    local width = 60
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

    if win_id = 0 then
        Logger:log(
            "ui#_create_window
end
