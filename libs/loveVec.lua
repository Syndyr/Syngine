e.oldCirc = love.graphics.circle
function love.graphics.circle(mode, pos, rad)
    
    e.oldCirc(mode, pos.x, pos.y, rad)
    
end

e.olDraw = love.graphics.draw
function love.graphics.draw(drawable, quad, pos, rad, scale, off, shear)
    
    if rad == nil then rad = 0 end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    
    e.olDraw(drawable, quad, pos.x, pos.y, rad, scale.x, scale.y, off.x, off.y, shear.x, shear.y)
    
end

e.olLine = love.graphics.line
function love.graphics.line(vecs)
   
    e.olLine(packVectorNicely(vecs))
    
end

e.olPoint = love.graphics.point
function love.graphics.point(pos)
    e.olPoint(pos.x, pos.y)
end

e.olgPrint = love.graphics.print
function love.graphics.print(str, pos, rad, scale, off, shear)
    
    if rad == nil then rad = 0 end
    if align == nil then align = "left" end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    e.olgPrint(str, pos.x, pos.y, rad, scale.x, scale.y, off.x, off.y, shear.x, shear.y)
    
end

e.olPrintf = love.graphics.printf
function love.graphics.printf(str, poslim, align, rad)
    if rad == nil then rad = 0 end
    if align == nil then align = "left" end
    e.olPrintf(str, posli.x, poslim.y, poslim.z, align, rad)
end

e.olRec = love.graphics.rectangle
function love.graphics.rectangle(mode, pos, scale)
    
    if rad == nil then rad = 0 end
    if pos == nil then pos = Vector(0, 0) end
    if scale == nil then scale = Vector(1, 1) end
    if off == nil then off = Vector(0, 0) end
    if shear == nil then shear = Vector(0, 0) end
    e.olRec(mode, pos.x, pos.y, scale.x, scale.y)
end

e.olnewQuad = love.graphics.newQuad
function love.graphics.newQuad(pos, size, sw, sh)
    return e.olnewQuad(pos.x, pos.y, size.x, size.y, sw, sh)
end

e.olwgetdia = love.graphics.getDimensions
function love.window.getDimensions()
    local sh, sw = e.olwgetdia()
    return Vector(sh, sw)
end

e.olgetmpos = love.mouse.getPosition
function love.mouse.getPosition()
    local px, py = e.olgetmpos()
    return Vector(px,py)
end