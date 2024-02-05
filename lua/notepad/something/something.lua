
function basename()
    local base_name = vim.fs.basename(vim.fn.getcwd())
    local parent_base_name = vim.fs.basename(vim.fs.dirname(vim.fn.getcwd()))
    print(parent_base_name .. '_' .. base_name ..'.md')
end
