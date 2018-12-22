print("Setting Vector table.")
local vecDef = {}
local vec = {
    __index = vecDef,
    __unm = function(a) 
        a.x = -a.x
        a.y = -a.y
        a.z = -a.z
        return a
    end,
    __add = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x + b.x
        solved.y = a.y + b.y
        solved.z = a.z + b.z
        return solved
    end,
    __sub = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x - b.x
        solved.y = a.y - b.y
        solved.z = a.z - b.z
        return solved
    end,
    __mul = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x * b.x
        solved.y = a.y * b.y
        solved.z = a.z * b.z
        return solved
    end,
    __div = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x / b.x
        solved.y = a.y / b.y
        solved.z = a.z / b.z
        return solved
    end,
    __mod = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x % b.x
        solved.y = a.y % b.y
        solved.z = a.z % b.z
        return solved
    end,
    __pow = function(a,b) 
        local solved = Vector(0,0,0)
        if type(b) == "number" then b = Vector(b,b,b) end
        solved.x = a.x ^ b.x
        solved.y = a.y ^ b.y
        solved.z = a.z ^ b.z
        return solved
    end,
    __eq = function(a,b)
        if a.x ~= b.x then return false end
        if a.y ~= b.y then return false end
        if a.z ~= b.z then return false end
        return true
    end,
    __lt = function(a,b)
        if a.x < b.x then return true end
        if a.y < b.y then return true end
        if a.z < b.z then return true end
        return false
    end,
    __le = function(a,b)
        if a.x <= b.x then return true end
        if a.y <= b.y then return true end
        if a.z <= b.z then return true end
        return false
    end
}
function vecDef:dist(b)
    if type(self) ~= "table" or type(self) ~= "table" or getmetatable(self) ~= vec then 
        return 0 
    else 
        if self.x == nil then 
            return 0 
        end
    end
    return math.sqrt((b.x-self.x)^2+(b.y-self.y)^2+(b.z-self.z)^2)
end
function vecDef:toString()
    str = "vector: [x="..self["x"]..", y="..self["y"]..", z="..self["z"].."]"
    return str
end
function vecDef:splitxyz(round)
    if round then
        return math.floor(self.x+0.5), math.floor(self.y+0.5), math.floor(self.z+0.5)
    else
        return self.x, self.y, self.z
    end
end
function vecDef:x(a) 
    if a ~= nil then self.x = a end
    return self.x end
function vecDef:y(a) 
    if a ~= nil then self.y = a end
    return self.y 
end
function vecDef:z(a) 
    if a ~= nil then self.z = a end
    return self.z 
end
function Vector(x,y,z)
    if z == nil then z = 0 end
    if y == nil then y = 0 end
    if x == nil then x = 0 end
    local t = {}
    if type(x) == "table" then 
        setmetatable(t, vec)
        t.x = x[1]
        t.y = x[2]
        t.z = x[3]
        
    else
        setmetatable(t, vec)
        t.x = x
        t.y = y
        t.z = z
    end
    return t
end
function v(x,y,z)
    return Vector(x,y,z)
end
function vecTabToSimpleTab(tab)
    for k,v in pairs(tab) do
        if getmetatable(v) == vec then
            t[#t+1] = v.x
            t[#t+1] = v.y
        end
    end
end
function packVectorNicely(...)
    return vecTabToSimpleTab(arg)
end
local tVec = Vector(1,1,0)
local tVe2 = Vector(5,5,0)
local tPls = tVec+tVe2

print(tVec:dist(tPls))
print("libs.vector done.")