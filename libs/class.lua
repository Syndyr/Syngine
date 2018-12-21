e.class = {
    bases = {},
    classes = {},
    __superClass = {
        __add = function(a, b)
            
            if a == nil or b == nil then return false end
            return e.class.mergWith(a, b)
            
        end
    }
}

function e.class.mergWith(aTable, selfa)
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
function e.class.getBase(base, domain)
    if domain == "e" then 
        domain = "engine" 
    elseif domain == "g" then 
        domain = "game" 
    end
    local baseName = domain:sub(1,1).."_"..base
    
    print("Getting base.. "..baseName)
    
    if e.class.bases[baseName] == nil then
        local aNewBase = setmetatable(require(domain..".classes.bases."..base), e.class.__superClass)
        if aNewBase.base ~= nil then
            local newDomain = aNewBase.base:sub(1,1)
            local newBaseName = aNewBase.base:sub(3)
            print("BASE REQUESTED "..aNewBase.base.." FROM "..domain:sub(1,1).."_"..base)
            local aNewerBase = e.class.getBase(newBaseName, newDomain)
            aNewBase = e.class.mergWith(aNewerBase, aNewBase)
        end
        e.class.bases[baseName] = aNewBase
        
        return e.class.bases[baseName]
    else
        return e.class.bases[baseName]
    end
    error("No base found for "..baseName)
end

--class = setmetatable({}, { __index = e.class})