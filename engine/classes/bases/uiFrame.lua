local FRAME = {}

FRAME.base = "e_base"
FRAME.name = "UI Frame"
FRAME.canvas = "no canvas?"
FRAME.objects = {}
FRAME.pos = v()
FRAME.posIsWorldSpace = false
FRAME.size = e.vpBounds

function FRAME:getCanvas()
    return self.canvas
end

function FRAME:setDraw(bool)
    assert(type(bool) == "boolean")
    self:getCanvas().doDraw = bool
end

function FRAME:add(type, objectData)
    table.insert(self.objects, e.class.getBase("ui"..type, "engine")+objectData )
end

function FRAME.drawMeta(dt, self)
    local mp = love.mouse.getPosition()
    local preCanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(self.canvas)
    if self.posIsWorldSpace then
        mp = mp + e.vp
    end
    local br = self.pos+self.size
    local thinkButtons = self.pos:inBounds2D(br, mp)
    print(Tserial.pack(self, true, true))
    e.ui.frames[self.otherData[1]].draw(dt, self)
    if self.objects == nil then self.objects = {} end
    for k,v in pairs(self.objects) do
        v:draw(dt, self, thinkButtons)
    end
    love.graphics.setCanvas(preCanvas)
end

function FRAME.draw(dt, self)
    love.graphics.rectangle("fill", v(125-62.5), v(125,62.5))
end

return FRAME