local FRAME = {}

FRAME.base = "e_base"
FRAME.name = "UI Frame"
FRAME.canvas = "no canvas?"
FRAME.objects = {}
FRAME.pos = v()
FRAME.posIsWorldSpace = false
FRAME.size = e.vpBounds

function FRAME:getMousePos()
    local mpos = love.mouse.getPosition()
    local solved = mpos - self.pos
    return solved
end

function FRAME:getCanvas()
    return self.canvas
end

function FRAME:setDraw(bool)
    assert(type(bool) == "boolean")
    self:getCanvas().doDraw = bool
end

function FRAME:add(type, objectData)
    local fData = e.class:getBase("uiObject", "engine")+objectData
    if objectData.pos ~= nil then
        fData.pos = objectData.pos
    end
    if objectData.size ~= nil then
        fData.size = objectData.size
    end
    if objectData.data.doDrawn ~= nil then
        fData.data.doDrawn = objectData.data.doDrawn
    end
    if type ~= nil then
        fData.type = type
    end
    if objectData.data ~= nil then
        fData.data = objectData.data
    end
    fData.frame = setmetatable({}, {__index = self})
    fData:init()
    self.objects[#self.objects+1] = e.table.copy(fData)
end

function FRAME.drawMeta(dt, self)
    
    local mp = love.mouse.getPosition()
    if self.posIsWorldSpace then
        mp = mp + e.vp
    end
    local br = self.pos+self.size
    local thinkButtons = self.pos:inBounds2D(br, mp)
    love.graphics.setColor(255,0,0)
    if thinkButtons then love.graphics.setColor(0,255,0) end
    love.graphics.setColor(255,255,255)
    e.ui.frames[self.otherData[1]].draw(dt, self)
    local selfa = e.ui.frames[self.otherData[1]]
    if selfa.objects == nil then selfa.objects = {} end
    for k,v in pairs(selfa.objects) do
        if v.draw ~= nil then
            v.draw(dt, v, thinkButtons, k, self)
        end
        if e.ui.debug then
            love.graphics.setColor(255,0,255)
            love.graphics.rectangle("line", v.pos-Vector(1,1), v.size+Vector(2,2))
            love.graphics.print(k.." "..v.pos:toString(), v.pos+Vector(v.size.x+4))
            love.graphics.setColor(255,255,255)
        end
    end
    
    if e.ui.debug then
        love.graphics.setColor(255,0,255)
        love.graphics.rectangle("line", v(), self.size)
        love.graphics.setColor(255,255,255)
    end
    love.graphics.setColor(255,255,255)
end

function FRAME.draw(dt, self)
    --love.graphics.rectangle("fill", v(125-62.5, 125-31.25), v(125,62.5))
end

return FRAME