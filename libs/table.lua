print("Defining table.copy function.")
local tabl = {
    __title = "Table library",
    __description = [[Provides helper functions for the table datatype]],
    __author = "Connor Day",
    __version = 1,
}
function tabl.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tabl.copy(orig_key)] = tabl.copy(orig_value)
        end
        setmetatable(copy, tabl.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
print("libs.table done.")

return tabl