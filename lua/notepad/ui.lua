local popup = require("plenary.popup")

local UI = {}
UI.__index = UI

function UI:new()
    return setmetatable({
        win_id = nil,
        bufnr = nil
    }, self)
end

function UI:create_notepad()
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

    if win_id == 0 then
        self.bufnr = bufnr
        self:close_notepad()
        error("Notepad: Failed to create popup")
    end

    -- Set win_id
    self.win_id = win_id

    return win_id, bufnr
end

function UI:close_notepad()
    if self.closing == true then
        return
    end

    self.closing = true

      if self.bufnr ~= nil and vim.api.nvim_buf_is_valid(self.bufnr) then
        vim.api.nvim_buf_delete(self.bufnr, { force = true })
    end

    if self.win_id ~= nil and vim.api.nvim_win_is_valid(self.win_id) then
        vim.api.nvim_win_close(self.win_id, true)
    end

    self.win_id = nil
    self.bufnr = nil
    self.closing = false
end
