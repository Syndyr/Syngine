olCirc = love.graphics.circle
function love.graphics.circle(mode, pos, rad)
    
    oldCirc(mode, pos.x, pos.y, rad)
    
end

olDraw = love.graphics.draw
function love.graphics.draw(drawable, quad, pos, rad, scale, off, shear)
    
    if rad == nil then rad = 0 end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    
    olDraw(drawable, quad, pos.x, pos.y, rad, scale.x, scale.y, off.x, off.y, shear.x, shear.y)
    
end

olLine = love.graphics.line
function love.graphics.line(vecs)
   
    olLine(packVectorNicely(vecs))
    
end

olPoint = love.graphics.point
function love.graphics.point(pos)
    olPoint(pos.x, pos.y)
end

olgPrint = love.graphics.print
function love.graphics.print(str, pos, rad, scale, off, shear)
    
    if rad == nil then rad = 0 end
    if align == nil then align = "left" end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    olgPrint(str, pos.x, pos.y, rad, scale.x, scale.y, off.x, off.y, shear.x, shear.y)
    
end

olPrintf = love.graphics.printf
function love.graphics.printf(str, poslim, align, rad)
    if rad == nil then rad = 0 end
    if align == nil then align = "left" end
    olPrintf(str, posli.x, poslim.y, poslim.z, align, rad)
end

olRec = love.graphics.rectangle
function love.graphics.rectangle(mode, pos, scale)
    
    if rad == nil then rad = 0 end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    olRec(mode, pos.x, pos.y, scale.x, scale.y)
end

olnewQuad = love.graphics.newQuad
function love.graphics.newQuad(pos, size, sw, sh)
    return olnewQuad(pos.x, pos.y, size.x, size.y, sw, sh)
end

olwgetdia = love.window.getDimensions
function love.window.getDimensions()
    local sh, sw = olwgetdia()
    return Vector(sh, sw)
end

olgetmpos = love.mouse.getPosition
function love.mouse.getPosition()
    local px, py = olgetmpos()
    return Vector(px,py)
end