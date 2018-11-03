print("Defining string.explode function.")
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
print("libs.string done.")