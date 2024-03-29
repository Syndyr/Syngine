print("Defining math.bearing.")
local maths = {
    __title = "Math library",
    __description = [[Provides math functions]],
    __author = "Connor Day",
    __version = 1,
}
function maths.bearing(a,b)
    
    if a ~= nil and b ~= nil then
        if type(a) == "table" and type(b) == "table" then
            
            local di ,de = a:dist(b) --The distance function handily outputs the deltas of the points inputed, so use that just to be lazy.
            local p1, p2 = de[1]*-1, de[2]*-1 --Lets just invert those, things get upside down if you don't.
            local rads = math.atan2(p1,p2)
            
            return rads, math.deg(rads)*-1+180
        end
        
        return 0, 0
    end
    
    return 0, 0
end

print("Defining math.round.")

function maths.round(val, decimal)
    local exp = decimal and 10^decimal or 1
    return math.ceil(val * exp - 0.5) / exp
end

function maths.maxmin(a,upper,lower)
    
    return math.max(math.min(a, upper), lower)
    
end

print("libs.math done.")
return maths