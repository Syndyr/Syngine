print("Defining string.explode function.")
local string = {
    __title = "String library",
    __description = [[Provides helper functions for the string datatype]],
    __author = "Connor Day",
    __version = 1,
}

function string.explode(stack, needle)
	if needle == nil then
		needle = "%S+"
	end
	if stack == nil then return "false" end
	local splitReturn = {}
	for i in string.gmatch(stack..needle, "([^"..needle.."]+)"..needle.."?")do
		print(i)
		table.insert(splitReturn, i)
	end
	return splitReturn
end

function string.toSeed(s)
    local trans = {
        ["0"] = 100,
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 5,
        ["6"] = 6,
        ["7"] = 7,
        ["8"] = 8,
        ["9"] = 10,
        ["a"] = 11,
        ["b"] = 12,
        ["c"] = 13,
        ["d"] = 14,
        ["e"] = 15,
        ["f"] = 16,
        ["g"] = 17,
        ["h"] = 18,
        ["i"] = 19,
        ["j"] = 20,
        ["k"] = 21,
        ["l"] = 22,
        ["m"] = 23,
        ["n"] = 24,
        ["o"] = 25,
        ["p"] = 26,
        ["q"] = 27,
        ["r"] = 28,
        ["s"] = 29,
        ["t"] = 30,
        ["u"] = 31,
        ["v"] = 32,
        ["w"] = 33,
        ["x"] = 34,
        ["y"] = 35,
        ["z"] = 36,
        [" "] = 36
    }
    s = string.lower(s)
    local i = 1
    local tes = 0
    --print(string.len(s))
    for i = 1, string.len(s) do
        if string.sub(s, i, (string.len(s)-i+1)*-1) ~= nil then
            tes = tes+trans[string.sub(s, i, (string.len(s)-i+1)*-1)]
        end
    end
    
    return tonumber(tes)
end
print("libs.string done.")
return string