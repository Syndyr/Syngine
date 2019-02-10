e.graphics = {}

function e.graphics.arch(type, triangulate, pos, od, id, archStart, archEnd, segments, idIsPercentage)
    
    assert(pos ~= nil, "No position for the Arch!")
    --assert(getmetatable(pos) == getmetatable(v()), "Position isn't a vector!")
    assert(od ~= nil, "No outer diameter for the Arch!")
    if od <= 0 then od = 1 end
    if id <= 0 then id = 0.5 end
    local tau = math.pi*2
    local sin = math.sin
    local cos = math.cos
    local points = {}
    local pointsOff = {}
    if type == nil then type = "line" end
    if idIsPercentage == nil then idIsPercentage = false end
    
    if id == nil then 
        id = od-25 
    elseif idIsPercentage then
        id = od-(od/id)
    end
    
    if archStart == nil or archStart == 0 then archStart = 0.00001 end
    if archEnd == nil then archEnd = tau/2 end
    if segments == nil then segments = 8 end
    local archDelta = archEnd-archStart
    if segments == "dynamic" then segments = math.max(16, math.floor((math.min(180, od/10))*(archDelta/tau) ) ) end
    segments = segments - 1
    local archDist = archDelta/segments
    
    local i = 0
    for i = 0, segments, 1 do
        
        local x,y = pos.x+(sin(archStart+(archDist*i))*od), pos.y+(cos(archStart+(archDist*i))*od)
        table.insert(points, x)
        table.insert(points, y)
        
    end
    for i = 0, segments, 1 do
        table.insert(points, pos.x+(sin(archEnd-(archDist*i))*id))
        table.insert(points, pos.y+(cos(archEnd-(archDist*i))*id))
    end
    
    if triangulate then
        local tris = love.math.triangulate(points)
        local i = 1
        for i = 1, #tris, 1 do
            love.graphics.polygon(type, tris[i])
        end
    else
        love.graphics.polygon(type, points)
    end
end