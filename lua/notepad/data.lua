local Path = require("plenary.path")

local data_path = vim.fn.stdpath("data")
local full_data_path = string.format("%s/notepad.json", data_path)

--- @param data any
function write_data(data)
    Path:new(full_data_path):write(vim.fn.json_encode(data), "w")
end

function read_data()
    local path = Path:new(full_data_path)
    local exists = path:exists()

    if not exists then
        write_data({})
    end

    local out_data = path:read()

    if not out_data or out_data == "" then
        write_data({})
        out_data = path:read()
    end

    local data = vim.json.decode(out_data)
    return data
end

function get_path()
    print(full_data_path)
    return full_data_path
end

--- @param key string
--- @param name string
--- @return string[]
function data(key, name)

end
