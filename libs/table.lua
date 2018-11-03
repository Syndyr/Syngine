print("Defining table.count function.")
function table.count(table) 
	if table ~= nil then
		return #table
	end
	return 0
end
print("Defining table.copy function.")
function table.copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[table.copy(orig_key)] = table.copy(orig_value)
        end
        setmetatable(copy, table.copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
print("libs.table done.")