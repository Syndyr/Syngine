print("Defining table.copy function.")
e.table = {}
function e.table.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[e.table.copy(orig_key)] = e.table.copy(orig_value)
        end
        setmetatable(copy, e.table.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
print("libs.table done.")
