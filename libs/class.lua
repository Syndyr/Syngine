classes = setmetatable({}, {
    
})
e.class = setmetatable({bases = {}, classes = {}}, {__index = class})

class = setmetatable({},{
    __add = function(a, b)
            
        local c = a
            
        for k,v in pairs(a) do
            if b[k] ~= nil then
                    
                c[k] = b[k]
                    
            end
        end
        return c
    end
})

function classes.newBase(str)
    if e.class.bases[str] == nil then
        
        local base = setmetatable(require("engine.classes.bases."..str), class)
        
        if base.base ~= nil then
            
            base = base + setmetatable(require("engine.classes.bases."..base.base), class)
            
        end
        
        e.class.bases[str] = setmetatable(base, class)
        
    end
end

function classes.getBase(str)
    if e.class.bases[str] == nil then
        
        classes.newBase(str)
        return classes.getBase(str)
        
    end
    return e.class.bases[str]
end