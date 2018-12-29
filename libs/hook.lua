e.hook = {
    hooks = {
        update = {},
        draw = {},
        resize = {},
        e_drawCallAux = {}
    }
}

function e.hook:getHooks()
    local str = {}
    for k,v in pairs(e.hook.hooks) do
        str[#str+1] = "Catagory: "..k.."\n"
        for n,b in pairs(v) do
            str[#str+1] = "Hook: "..n.."\n"
        end
    end
    return str
end

function e.hook:run(name, dt)
    if dt == nil then dt = e.dt end
    if self.hooks[name] == nil then 
        self:new(name)
        return false
    end
    
    for k, v in pairs(self.hooks[name]) do
        v.v(dt)
    end
end

function e.hook:new(name)
    if self.hooks[name] ~= nil then
        self.hooks[name] = {}
    else
        return false
    end
end

function e.hook:add(hook, name, func)
    if self.hooks[hook] == nil then
        self:new(hook)
    end
    self.hooks[hook][name] = {n = name, v = func}
end

function e.hook:remove(domain, name)
    if e.hook.hooks[domain] ~= nil then
        if e.hook.hooks[domain][name] ~= nil then
            e.hook.hooks[domain][name] = nil
        else
            print("No such hook as: "..domain.."/"..name)
        end
    else
        print("No such domain as: "..domain)
    end
end