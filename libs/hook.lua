e.hook = {
    hooks = {
        update = {},
        draw = {}
    }
}
function e.hook:getHooks()
    for k,v in pairs(e.hook.hooks) do
        print("Catagory: "..k)
        for n,b in pairs(v) do
            print("\tHook "..n)
        end
    end
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
    if self.hooks[hook] ~= nil then
        self:new(hook)
    end
    self.hooks[hook][name] = {n = name, v = func}
end