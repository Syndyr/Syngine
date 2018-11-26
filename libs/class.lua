e.class = {
    bases = {},
    classes = {},
    __superClass = {
        __add = function(a, b)
            local c = a
            for k,v in pairs(a) do
                if b[k] ~= nil then
                    c[k] = b[k]
                end
            end
            return c
        end
    }
}
function e.class.getBase(domain, base)
    local baseName = domain:sub(1,1).."_"..base
    print("Getting base.. "..baseName)
    if e.class.bases[baseName] == nil then
        local aNewBase = setmetatable(require(domain..".classes.bases."..base), e.class.__superClass)
        e.class.bases[baseName] = aNewBase
        if aNewBase.base ~= nil then 
            aNewbase = aNewbase + e.class.getBase(aNewBase.base)
        end
        return e.class.bases[baseName]
    else
        return e.class.bases[baseName]
    end
end
function e.class.getClass(name, domain, tab)
    if tab == nil then 
        tab =  setmetatable(require(domain..".classes.bases."..base), e.class.__superClass)
    end
    local className = domain:sub(1,1).."_"..base
    local base = "e_base"
    local aNewClass = tab
    if tab.base ~= nil then base = tab.base end
    if e.class.classes[className] == nil then
        aNewClass = aNewClass + e.class.getBase(base)
        e.class.classes[className] = aNewClass
    else
        return e.class.classes[className]
    end
    return e.class.classes[className]
end

class = setmetatable({}, { __index = e.class})