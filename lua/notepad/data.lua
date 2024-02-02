local Path = require("plenary.path")

local data_path = vim.fn.stdpath("data")
local full_data_path = string.format("%s/notepad.txt", data_path)

-- Initial plan is to store the data in a txt file located in the directory
-- I want to use the path as a key in a sens so that we can have per project
-- notes in a file.

-- First to start let's just have one global notepad

--- @param data string
local function write_note(data)
    Path:new(full_data_path):write(data, "w")
end

-- Module to read and write data to a file
local M = {}

function M.info()
    return {
        print(data_path),
        print(full_data_path)
    }
end

function M.set_data_path(path)
    full_data_path = path
end


-- This is raw data but it is a txt file for now
function M.read_data()
    local path = Path:new(full_data_path)
    local exists = path:exists()
    if not exists then
        write_note("")
    end

    local out_data = path:read()

    if not out_data or out_data == "" then
        write_note("")
        out_data = path:read()
    end

    local data = out_data
    print(data)
    return data
end

function M.new()
    local ok, data = pcall(M.read_data)

    return setmetatable({
        data = data,
        has_error = not ok,
        seen = {}
    }, M)
end

return M
