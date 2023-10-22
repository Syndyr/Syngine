local class = {
    __title = "Class library",
    __description = [[Provides my OOP lite system, basic class management, merging and dependancy chains]],
    __author = "Connor Day",
    __version = 1,
    bases = {},
    classes = {},
}
function class.mergWith(aTable, selfa)
    local newTable = e.table.copy(selfa)
    if newTable == nil or selfa == nil then 
        return {}
    end
    for k,v in pairs(aTable) do
        if newTable[k] ~= nil or newTable[k] ~= v then
            newTable[k] = v
        end
    end
    return newTable
end

function class:getBase(base, domain)
    if domain == "e" then 
        domain = "engine" 
    elseif domain == "g" then 
        domain = "game" 
    end
    local baseName = domain:sub(1,1).."_"..base
    
    if self.bases[baseName] == nil then
        local aNewBase = setmetatable(require(domain..".classes.bases."..base), self.__superClass)
        if aNewBase.base ~= nil then
            local newDomain = aNewBase.base:sub(1,1)
            local newBaseName = aNewBase.base:sub(3)
            print("BASE REQUESTED "..aNewBase.base.." FROM "..domain:sub(1,1).."_"..base)
            local aNewerBase = self:getBase(newBaseName, newDomain)
            aNewBase = self.mergWith(aNewerBase, aNewBase)
        end
        self.bases[baseName] = aNewBase
        
        return self.bases[baseName]
    else
        return self.bases[baseName]
    end
    error("No base found for "..baseName)
end
class.__superClass = {
        __add = function(a, b)
            
            if a == nil or b == nil then return false end
            return class.mergWith(a, b)
            
        end
    }
return class